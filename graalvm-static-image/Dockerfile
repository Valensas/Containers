ARG GRAALVM_VERSION=ol9-java17-22.3.1

FROM ghcr.io/graalvm/native-image:${GRAALVM_VERSION}

ARG MUSL_VERSION=10.2.1
ARG ZLIB_VERSION=1.2.13

WORKDIR /libs

# Install musl libc
RUN microdnf -y install wget gzip findutils
RUN wget https://more.musl.cc/${MUSL_VERSION}/x86_64-linux-musl/x86_64-linux-musl-native.tgz
RUN tar -xzf x86_64-linux-musl-native.tgz
RUN rm -rf x86_64-linux-musl-native.tgz

# Install zlib with static support
RUN wget https://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
RUN tar -xzf zlib-${ZLIB_VERSION}.tar.gz
RUN rm -rf zlib-${ZLIB_VERSION}.tar.gz
ENV TOOLCHAIN_DIR=/libs/x86_64-linux-musl-native
ENV CC=${TOOLCHAIN_DIR}/bin/gcc
WORKDIR /libs/zlib-${ZLIB_VERSION}
RUN ./configure --prefix=${TOOLCHAIN_DIR} --static
RUN make
RUN make install
RUN rm -rf zlib-${ZLIB_VERSION}

ENV PATH=${TOOLCHAIN_DIR}/bin/:${PATH}
WORKDIR /app
