# odroid-hc2

FROM ubuntu:20.04 as builder

#Credits to https://github.com/Byloth/cmangos-docker for figuring out a lot of this stuff

#To build: docker build -t s3v1/cmangos-classic:latest .
#To run: docker run --rm -it s3v1/cmangos-classic:latest

# docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag s3v1/cmangos-classic:latest .

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get install -y build-essential gcc g++ automake git-core autoconf make patch libmysql++-dev libtool libssl-dev grep binutils zlibc libc6 libbz2-dev cmake libboost-all-dev && \
    apt-get auto-remove -y
curl -L -k https://github.com/Baeldung/kotlin-tutorials/tarball/master | tar -xz
WORKDIR /wrk

COPY . . 

RUN rm -rf build
RUN nice cmake --clean-first -B build . -DCMAKE_INSTALL_PREFIX=build/output -DPCH=1 -DDEBUG=0 -DBUILD_EXTRACTORS=ON -DBUILD_PLAYERBOT=ON -DBUILD_AHBOT=ON -DFORCE_32B=ON
RUN nice make -C build -j$(nproc) 
RUN nice make -C build install

FROM ubuntu:20.04 as runner

COPY --from=builder /wrk/build/output/ /wrk
