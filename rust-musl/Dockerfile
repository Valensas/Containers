FROM rust:1.70.0-slim-bookworm

RUN apt-get update && apt-get install -y \
    build-essential=12.9 \
    wget=1.21.3-1+b2 \
    ca-certificates=20230311 \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/local && \
    wget https://musl.cc/x86_64-linux-musl-cross.tgz && \
    tar xzf x86_64-linux-musl-cross.tgz && \
    rm x86_64-linux-musl-cross.tgz && \
    apt remove wget -y


ENV PATH="/usr/local/x86_64-linux-musl-cross/bin:${PATH}"
ENV CC_x86_64_unknown_linux_musl=x86_64-linux-musl-gcc
ENV TARGET_CC=x86_64-linux-musl-gcc
ENV TARGET_AR=x86_64-linux-musl-ar