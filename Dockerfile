FROM debian:stable-slim

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

RUN adduser \
    --home "$USER_HOME" \
    --uid $USER_ID \
    --gecos "$USER_GECOS" \
    --disabled-password \
    "$USER_NAME"

ARG TEX_IMAGE=texlive
ARG TEX_LANGS="german"
ARG TEX_EXTRA="latex-extra bibtex-extra extra-utils"
ARG PYTHON_VERSION=python3
ARG PYTHON_PACKAGES="pygments"
ARG MORE_PACKAGES="latexmk"

RUN apt-get update && apt-get install -y \
    $TEX_IMAGE \
    $(for i in $TEX_LANGS;do echo "texlive-lang-$i";done) \
    $(for i in $TEX_EXTRA;do echo "texlive-$i";done) \
    $(for i in $PYTHON_PACKAGES;do echo $PYTHON_VERSION"-$i";done) \
    $(for i in $MORE_PACKAGES;do echo "$i";done) \
    && rm -rf /var/lib/apt/lists/*

USER $USER_NAME
