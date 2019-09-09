FROM python:3.7.4-alpine AS base

ENV CPPCHECK_VERSION=1.88

WORKDIR /tmp/cppcheck

RUN apk add --no-cache -t .required_apks git=2.22.0-r0 make=4.2.1-r2 g++=8.3.0-r0 pcre-dev=8.43-r0 && \
    git clone --single-branch https://github.com/danmar/cppcheck.git . && \
    git checkout tags/$CPPCHECK_VERSION && \
    make install CFGDIR=/etc/cppcheck/cfg HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function --static" && \
    apk del .required_apks && \
    echo -e "#!/bin/sh\ncppcheck --dump .\n misra.py \`find . -name '*.dump' | tr '\n' ' '\` 2> misra-report.txt" > /usr/bin/misra && chmod +x /usr/bin/misra

FROM python:3.7.4-alpine
RUN rm -rf /lib/apk /etc/apk /home /var /tmp /srv /media /mnt /run /sbin /opt
COPY --from=base /usr/bin/cppcheck /usr/bin/misra /usr/bin/*.py /usr/bin/
COPY --from=base /etc/cppcheck /etc/cppcheck

LABEL maintainer="begarco"
WORKDIR /src

ENTRYPOINT ["sh", "-c"]
