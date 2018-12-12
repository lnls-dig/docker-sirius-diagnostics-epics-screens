Docker image with Sirius Diagnostics CSS OPIs
===============================

Overview
--------

This repository contains Docker recipes for generating
a Docker image containing the Sirius Diagnostics OPIs.

This was designed to be used as a docker bind mount to the
NFS-server available here: https://github.com/lnls-dig/docker-nfs-server-css-opi-composed

### Create image containing entire CSS Diagnostics OPIs (for usage as a volume in nfs-server)

    docker build \
        --build-arg SOURCE_COMMIT=$(git describe --dirty --always --abbrev=10) \
        --build-arg BUILD_DATE=$(date +%Y%m%d-%H%M%S) \
        -t lnlsdig/sirius-diagnostics-epics-screens .

Most of the time the dockerhub image should be used, not the
locally generated ones. If in doubt use the dockerhub one.
