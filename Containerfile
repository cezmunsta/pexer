ARG BASE=quay.io/centos/centos:stream9
ARG BUNDLE=bundle.tgz
ARG ENTRYPOINT=python3
ARG PACKAGE=demo
ARG PYTHON_VERSION=3.9
ARG USER_NAME=nobody
ARG USER_UID=1000

FROM "${BASE}"

ARG BASE
ARG BUNDLE
ARG ENTRYPOINT
ARG PACKAGE
ARG PYTHON_VERSION
ARG USER_NAME
ARG USER_UID

COPY scripts /opt/scripts
COPY "${BUNDLE}" /opt

RUN bash -x /opt/scripts/build-image.sh \
        "$(basename "${BASE}")" \
        "/opt/$(basename "${BUNDLE}")" \
        "${PYTHON_VERSION}"

ENV ENTRYPOINT="${ENTRYPOINT}"

USER "${USER_NAME}"
WORKDIR /app
ENTRYPOINT "${ENTRYPOINT}"
CMD ["--version"]
VOLUME ["/app"]
