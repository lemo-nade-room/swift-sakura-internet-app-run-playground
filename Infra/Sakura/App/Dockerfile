# ================================
# Build image
# ================================
FROM swift:6.2-noble AS build

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get install -y libjemalloc-dev

WORKDIR /build

RUN mkdir /staging
RUN --mount=type=bind,source=.,target=/src,readonly \
    --mount=type=cache,target=/tmp/swift-build \
    export BUILD_PATH=/tmp/swift-build && \
    swift build -c release \
        --product App \
        --build-path $BUILD_PATH \
        --static-swift-stdlib \
        -Xlinker -ljemalloc && \
    cp "$(swift build -c release --build-path $BUILD_PATH --show-bin-path)/App" /staging


WORKDIR /staging

RUN cp "/usr/libexec/swift/linux/swift-backtrace-static" ./

# ================================
# Run image
# ================================
FROM ubuntu:noble

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get -q install -y \
      libjemalloc2 \
      ca-certificates \
      tzdata \
    && rm -r /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /staging /app
ENV SWIFT_BACKTRACE=enable=yes,sanitize=yes,threads=all,images=all,interactive=no,swift-backtrace=./swift-backtrace-static
EXPOSE 8080
ENTRYPOINT ["./App"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]