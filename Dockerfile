FROM python:3.8.5-slim-buster AS base

ENV CPPCHECK_VERSION=2.1

WORKDIR /tmp/cppcheck

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    git \
    make \
    g++ \
    z3 \
    libz3-dev \
    libpcre3-dev \
 && git clone --single-branch https://github.com/danmar/cppcheck.git . \
 && git checkout tags/$CPPCHECK_VERSION \
 && make install -j32 USE_Z3=yes HAVE_RULES=yes MATCHCOMPILER=yes FILESDIR=/etc/cppcheck CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function" \
 && echo -e "#!/bin/sh\ncppcheck --dump .\n misra.py \`find . -name '*.dump' | tr '\n' ' '\` 2> misra-report.txt" > /usr/bin/misra && chmod +x /usr/bin/misra

FROM python:3.8.5-slim-buster
RUN pip install --trusted-host pypi.org pygments \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends \
    z3 \
    libz3-dev \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /lib/apk /etc/apk /home /var /tmp /srv /media /mnt /run /sbin /opt
COPY --from=base /usr/bin/cppcheck /usr/bin/cppcheck-htmlreport /usr/bin/misra /usr/bin/*.py /usr/bin/
COPY --from=base /etc/cppcheck /etc/cppcheck

LABEL maintainer="begarco"
WORKDIR /src

ENTRYPOINT ["sh", "-c"]
