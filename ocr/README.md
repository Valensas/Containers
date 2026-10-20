# OCR Viewer

```bash
docker pull valensas/ocr:1.13.2
```

Container image for the session viewer of [Open Code Review](https://github.com/alibaba/open-code-review) (OCR).
OCR ships no container image of its own: its npm package only downloads a per-platform binary from GitHub Releases.
This image fetches that binary, verifies it against the release's `sha256sum.txt`, and runs it on
[distroless static](https://github.com/GoogleContainerTools/distroless) as the `nonroot` user.

## Usage

```bash
docker run --rm -p 5483:5483 \
  -v /path/to/sessions:/data/.opencodereview/sessions:ro \
  valensas/ocr:1.13.2
```

Then open http://localhost:5483.

- The viewer reads sessions from `$HOME/.opencodereview/sessions`, and `HOME` is `/data` in the image.
  The mount can be read-only, since the viewer never writes.
- OCR writes session directories as `0700` and files as `0600`, so they must be owned by the UID the container
  runs as (`65532` by default). Either `chown -R 65532:65532` the sessions, or run with `--user <owner uid>:<gid>`.
- The viewer has no authentication. Do not expose it directly; put it behind something like
  [oauth2-proxy](https://github.com/oauth2-proxy/oauth2-proxy).

Keep the image version in step with the OCR CLI that writes the sessions: the session format is defined by the CLI,
and only matching versions are guaranteed to render correctly.

## Building

The OCR version is set with the `OCR_VERSION` build argument:

```bash
docker buildx build --platform linux/amd64 \
  --build-arg OCR_VERSION=1.13.2 \
  -t valensas/ocr:1.13.2 \
  ocr
```

`linux/arm64` works too; the matching release binary is picked from `TARGETARCH`.

Pushing an `ocr/<version>` tag publishes `valensas/ocr:<version>` through the repository workflow. The workflow
passes no build arguments, so update the default `OCR_VERSION` in the `Dockerfile` before tagging.
