# Rust Musl

Container image based on [rust:slim-bookworm](https://hub.docker.com/_/rust), with added musl support to allow compilation of staticially linked binaries.
Using static binaries, you can run your Rust binaries `FROM scratch`, allowing smaller and more secure container images.

## Usage

```docker
FROM ghcr.io/valensas/rust-musl:1.70.0 as build

WORKDIR /app/my-project

ENV RUST_BACKTRACE full

RUN rustup target add x86_64-unknown-linux-musl

RUN mkdir src && \
    echo "fn main() {}" >> src/main.rs

COPY Cargo.lock Cargo.toml ./

RUN cargo build --target x86_64-unknown-linux-musl --release

COPY src ./src

RUN rm ./target/x86_64-unknown-linux-musl/release/deps/my-project-*

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM scratch

COPY --from=build /app/my-project/target/x86_64-unknown-linux-musl/release/my-project ./

CMD ["./my-project"]
```