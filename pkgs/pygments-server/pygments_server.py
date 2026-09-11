"""Long-running pygmentize.

Each request on the unix socket is three netstrings ("1" if the last
argument was a readable file whose contents follow as input, argv joined
by NUL, input) and is answered with three netstrings (exit code, stdout,
stderr). The client binary maps
that back onto the pygmentize command line contract SyntaxHighlight uses,
so CPython start-up and `import pygments` are paid once instead of per
<syntaxhighlight> block.
"""

import io
import os
import socket
import socketserver
import sys
import threading
from contextlib import redirect_stderr, redirect_stdout

import pygments.cmdline
import pygments.lexers

MAX_REQUEST = 8 * 1024 * 1024

# pygments.cmdline mutates sys.std* and is not re-entrant
_lock = threading.Lock()


def read_netstring(f: io.BufferedIOBase) -> bytes:
    length = b""
    while (c := f.read(1)) != b":":
        if not c or len(length) > 10:
            raise ValueError("bad netstring length")
        length += c
    n = int(length)
    if n > MAX_REQUEST:
        raise ValueError("request too large")
    data = f.read(n)
    if len(data) != n or f.read(1) != b",":
        raise ValueError("truncated netstring")
    return data


def netstring(b: bytes) -> bytes:
    return str(len(b)).encode() + b":" + b + b","


def run(argv: list[str], stdin: bytes) -> tuple[int, bytes, bytes]:
    out = io.BytesIO()
    err = io.BytesIO()
    tout = io.TextIOWrapper(out, encoding="utf-8", write_through=True)
    terr = io.TextIOWrapper(err, encoding="utf-8", write_through=True)
    with _lock:
        old_stdin = sys.stdin
        sys.stdin = io.TextIOWrapper(io.BytesIO(stdin), encoding="utf-8")
        try:
            with redirect_stdout(tout), redirect_stderr(terr):
                try:
                    rc = pygments.cmdline.main(["pygmentize", *argv])
                except SystemExit as e:
                    rc = e.code if isinstance(e.code, int) else 1
        finally:
            sys.stdin = old_stdin
    tout.flush()
    terr.flush()
    return int(rc or 0), out.getvalue(), err.getvalue()


class Handler(socketserver.StreamRequestHandler):
    def handle(self) -> None:
        try:
            has_file = read_netstring(self.rfile) == b"1"
            argv = read_netstring(self.rfile).split(b"\0")
            stdin = read_netstring(self.rfile)
        except ValueError as e:
            self.wfile.write(
                netstring(b"2") + netstring(b"") + netstring(str(e).encode())
            )
            return
        args = [a.decode() for a in argv if a]
        if has_file:
            args = args[:-1]
        rc, out, err = run(args, stdin)
        self.wfile.write(netstring(str(rc).encode()) + netstring(out) + netstring(err))


class Server(socketserver.ThreadingMixIn, socketserver.UnixStreamServer):
    daemon_threads = True

    def server_bind(self) -> None:
        fds = int(os.environ.get("LISTEN_FDS", "0"))
        if fds >= 1 and int(os.environ.get("LISTEN_PID", "0")) == os.getpid():
            self.socket = socket.fromfd(3, socket.AF_UNIX, socket.SOCK_STREAM)
            return
        super().server_bind()


def main() -> None:
    # warm the lexer registry so the first request is not slow either
    for _ in pygments.lexers.get_all_lexers():
        pass
    path = sys.argv[1] if len(sys.argv) > 1 else "/run/pygments-server/socket"
    with Server(path, Handler) as srv:
        srv.serve_forever()


if __name__ == "__main__":
    main()
