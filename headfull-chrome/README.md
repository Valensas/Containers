# Headfull Chrome

```bash
docker pull valensas/headfull-chrom:java21-chrome131
```

This container image is based on [Ubuntu](https://hub.docker.com/_/ubuntu)
together with Java, Chrome and X virtual frame buffer.

The primary purpose of this image is to be used in java projects with selenium
where ChromeDriver with `--headless=new` header is necessary to avoid browser detection.
