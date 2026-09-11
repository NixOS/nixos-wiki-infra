{
  lib,
  runCommand,
  rustPlatform,
  python3,
  socketPath ? "/run/pygments-server/socket",
}:
let
  python = python3.withPackages (ps: [ ps.pygments ]);

  client = rustPlatform.buildRustPackage {
    pname = "pygmentize-client";
    version = "0.1.0";
    src = ./client;
    cargoLock.lockFile = ./client/Cargo.lock;
    env = {
      PYGMENTS_SERVER_SOCKET = socketPath;
      PYGMENTS_SERVER_FALLBACK = "${python3.pkgs.pygments}/bin/pygmentize";
    };
    meta.mainProgram = "pygmentize";
  };
in
runCommand "pygments-server"
  {
    passthru = { inherit client socketPath; };
    meta = {
      description = "Keeps pygmentize resident behind a unix socket for MediaWiki SyntaxHighlight";
      license = lib.licenses.mit;
      mainProgram = "pygments-server";
    };
  }
  ''
    install -Dm644 ${./pygments_server.py} $out/libexec/pygments_server.py
    mkdir -p $out/bin
    cat > $out/bin/pygments-server <<EOF
    #!/bin/sh
    exec ${python.interpreter} $out/libexec/pygments_server.py "\$@"
    EOF
    chmod +x $out/bin/pygments-server
    ln -s ${client}/bin/pygmentize $out/bin/pygmentize
  ''
