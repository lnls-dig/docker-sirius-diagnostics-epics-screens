FROM debian:9.5 as builder

ENV SCREENS_REPO sirius-diagnostics-epics-screens
ENV COMMIT master

USER root

WORKDIR /

RUN echo "nameserver 10.0.0.71"  >> /etc/resolv.conf && \
    apt-get update && \
    apt-get install -y \
        git \
        make && \
    git clone https://github.com/lnls-dig/${SCREENS_REPO} /${SCREENS_REPO} && \
    cd /${SCREENS_REPO} && \
    git checkout ${COMMIT} && \
    make

FROM debian:9.5

ENV SCREENS_REPO sirius-diagnostics-epics-screens

# Add the option to set the git commit as metadata
# (This arg is set automatically in the Docker Cloud builds)
ARG SOURCE_COMMIT=unknown
ARG BUILD_DATE=unknown

LABEL \
    com.github.lnls-sirius.license="GPLv3" \
    com.github.lnls-sirius.docker.dockerfile="Dockerfile" \
    com.github.lnls-sirius.vcs-type="Git" \
    com.github.lnls-sirius.vcs-url="https://github.com/lnls-dig/docker-sirius-diagnostics-epics-screens.git" \
    git-commit=$SOURCE_COMMIT \
    build-date=$BUILD_DATE \
    maintainer="Lucas Russo"

COPY --from=builder /${SCREENS_REPO}/build/op/opi /sirius-diagnostics-epics-screens

VOLUME /sirius-diagnostics-epics-screens
