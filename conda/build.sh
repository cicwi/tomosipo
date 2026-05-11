#!/bin/sh

set -eux

PIP_DISABLE_PIP_VERSION_CHECK=1 \
    "${PYTHON}" -m pip install . --no-deps --no-build-isolation --no-index -vv
