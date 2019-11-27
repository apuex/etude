RUSTFLAGS='-l static=pthread -l static=m' ~/.cargo/bin/cargo build --release --target mipsel-unknown-linux-musl
RUSTFLAGS='-l static=pthread -l static=m' ~/.cargo/bin/cargo build --release
RUSTFLAGS='-C target-feature=+crt-static -l static=m' ~/.cargo/bin/cargo build --release
RUSTFLAGS='--crate-type=static -l static=m' ~/.cargo/bin/cargo build --release

