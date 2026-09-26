FROM python:3.14.7-slim-bookworm AS base

ENV CPPCHECK_VERSION=2.21.0

WORKDIR /tmp/cppcheck

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    git \
    make \
    g++ \
    z3 \
    libz3-dev \
    libpcre3-dev \
 && git clone --single-branch -b $CPPCHECK_VERSION https://github.com/cppcheck-opensource/cppcheck.git . \
 && make install USE_Z3=yes HAVE_RULES=yes MATCHCOMPILER=yes FILESDIR=/etc/cppcheck CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function"

FROM python:3.14.7-slim-bookworm

RUN pip install --trusted-host pypi.org pygments \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends \
    z3 \
    libz3-dev \
    libpcre3-dev \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /lib/apk /etc/apk /home /var /tmp /srv /media /mnt /run /sbin /opt
COPY --from=base /usr/bin/cppcheck /usr/bin/cppcheck-htmlreport /usr/bin/
COPY --from=base /etc/cppcheck /etc/cppcheck

LABEL maintainer="begarco"
WORKDIR /src
