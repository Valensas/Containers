FROM alpine:3.22 AS fetch
ARG OCR_VERSION=1.13.2
ARG TARGETARCH=amd64
RUN apk add --no-cache ca-certificates curl
RUN set -eux; \
    base="https://github.com/alibaba/open-code-review/releases/download/v${OCR_VERSION}"; \
    asset="opencodereview-linux-${TARGETARCH}"; \
    curl -fsSL -o /tmp/ocr "${base}/${asset}"; \
    curl -fsSL -o /tmp/sha256sum.txt "${base}/sha256sum.txt"; \
    # Fails the build if the asset is missing from the checksum file
    # (the assignment carries grep's exit status under set -e).
    line="$(grep " ${asset}\$" /tmp/sha256sum.txt)"; \
    echo "${line%% *}  /tmp/ocr" | sha256sum -c -; \
    chmod +x /tmp/ocr

FROM gcr.io/distroless/static-debian12:nonroot
ARG OCR_VERSION=1.13.2
LABEL org.opencontainers.image.title="ocr-viewer" \
      org.opencontainers.image.version="${OCR_VERSION}" \
      org.opencontainers.image.source="https://github.com/alibaba/open-code-review"
COPY --from=fetch /tmp/ocr /usr/local/bin/ocr
ENV HOME=/data
USER 65532:65532
EXPOSE 5483
ENTRYPOINT ["/usr/local/bin/ocr"]
CMD ["viewer", "--addr", ":5483", "--open=never"]