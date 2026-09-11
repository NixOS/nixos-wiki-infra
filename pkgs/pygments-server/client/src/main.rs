//! Drop-in for `pygmentize` that forwards to pygments-server, see
//! pygments_server.py for the wire format. Falls back to the real binary
//! when the daemon is not reachable so highlighting never hard-fails.

use std::env;
use std::fs;
use std::io::{self, BufRead, BufReader, IsTerminal, Read, Write};
use std::net::Shutdown;
use std::os::unix::net::UnixStream;
use std::os::unix::process::CommandExt;
use std::process::{exit, Command};

const SOCKET_PATH: &str = env!("PYGMENTS_SERVER_SOCKET");
const FALLBACK: &str = env!("PYGMENTS_SERVER_FALLBACK");

fn fallback(args: &[String]) -> ! {
    let err = Command::new(FALLBACK).args(args).exec();
    eprintln!("pygmentize-client: exec {FALLBACK}: {err}");
    exit(127);
}

fn write_netstring(w: &mut impl Write, data: &[u8]) -> io::Result<()> {
    write!(w, "{}:", data.len())?;
    w.write_all(data)?;
    w.write_all(b",")
}

fn read_netstring(r: &mut impl BufRead) -> io::Result<Vec<u8>> {
    let mut len = Vec::new();
    r.read_until(b':', &mut len)?;
    len.pop();
    let len: usize = std::str::from_utf8(&len)
        .ok()
        .and_then(|s| s.parse().ok())
        .ok_or(io::ErrorKind::InvalidData)?;
    let mut buf = vec![0; len + 1];
    r.read_exact(&mut buf)?;
    if buf.pop() != Some(b',') {
        return Err(io::ErrorKind::InvalidData.into());
    }
    Ok(buf)
}

fn request(
    mut sock: UnixStream,
    args: &[String],
    has_file: bool,
    input: &[u8],
) -> io::Result<(i32, Vec<u8>, Vec<u8>)> {
    write_netstring(&mut sock, if has_file { b"1" } else { b"0" })?;
    write_netstring(&mut sock, args.join("\0").as_bytes())?;
    write_netstring(&mut sock, input)?;
    sock.shutdown(Shutdown::Write)?;
    let mut r = BufReader::new(sock);
    let rc = read_netstring(&mut r)?;
    let out = read_netstring(&mut r)?;
    let err = read_netstring(&mut r)?;
    let rc = std::str::from_utf8(&rc)
        .ok()
        .and_then(|s| s.parse().ok())
        .ok_or(io::ErrorKind::InvalidData)?;
    Ok((rc, out, err))
}

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();
    let Ok(sock) = UnixStream::connect(SOCKET_PATH) else {
        fallback(&args)
    };

    // SyntaxHighlight passes the code as a trailing file argument that
    // lives in a private temp dir, so ship its contents instead.
    let file = match args.last() {
        Some(last) if args.len() >= 2 && !last.starts_with('-') => fs::read(last).ok(),
        _ => None,
    };
    let has_file = file.is_some();
    let input = file.unwrap_or_else(|| {
        let mut buf = Vec::new();
        if !io::stdin().is_terminal() {
            let _ = io::stdin().read_to_end(&mut buf);
        }
        buf
    });

    match request(sock, &args, has_file, &input) {
        Ok((rc, out, err)) => {
            let _ = io::stdout().write_all(&out);
            let _ = io::stderr().write_all(&err);
            exit(rc);
        }
        Err(e) => {
            eprintln!("pygmentize-client: {e}");
            exit(2);
        }
    }
}
