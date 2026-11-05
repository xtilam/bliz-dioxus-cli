{
  description = "Development shell for the bliz Dioxus CLI (dx)";

  inputs = {
    # nixos-26.05 currently ships rustc 1.95, but the latest compatible
    # dependency set requires Rust 1.96+. nixos-unstable provides Rust 1.99.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
            }
          )
        );
    in
    {
      devShells = forAllSystems (
        pkgs:
        let
          inherit (pkgs) lib stdenv;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              cargo
              rustc
              rustfmt
              clippy
              rust-analyzer
              pkg-config
              cacert
              git
              esbuild
              wasm-bindgen-cli
              binaryen
            ];

            buildInputs =
              with pkgs;
              [ openssl ]
              ++ lib.optionals stdenv.isDarwin [
                libiconv
              ];

            env = {
              OPENSSL_NO_VENDOR = "1";
              RUST_BACKTRACE = "1";
              SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
              NIX_SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
            };

            shellHook = ''
              echo "dioxus-cli dev shell"
              echo "  cargo build --bin dx   -> target/debug/dx"
              echo "  cargo build --release  -> target/release/dx"
            '';
          };
        }
      );
    };
}
