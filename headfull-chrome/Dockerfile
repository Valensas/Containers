FROM ubuntu:24.04

ARG CHROME_VERSION="131.0.6778.85-1"

RUN apt update -y && apt upgrade -y && \
    apt-get install -y --no-install-recommends openjdk-21-jdk \
    wget \
    libcurl4t64 fonts-liberation xdg-utils libgbm1 \
    xvfb
RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb
RUN dpkg -i google-chrome-stable_${CHROME_VERSION}_amd64.deb && \
    apt-get -y remove --purge wget && \
    rm -rf /var/lib/apt/lists/* && rm google-chrome-stable_${CHROME_VERSION}_amd64.deb

ENV DISPLAY=:99
