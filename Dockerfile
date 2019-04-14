FROM alpine:latest

MAINTAINER begarco

ENV CPPCHECK_VERSION=1.87

RUN	apk add --no-cache -t .required_apks git make g++ pcre-dev && \
	mkdir -p /tmp/cppcheck /src && cd /tmp/cppcheck && \
	git clone https://github.com/danmar/cppcheck.git . && \
	git checkout tags/$CPPCHECK_VERSION && \
	make install CFGDIR=/cfg HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function --static" && \
	strip /usr/bin/cppcheck && \
	apk del .required_apks && \
	mkdir -p /src && \
	rm -rf /tmp/cppcheck

WORKDIR /src

ENTRYPOINT ["sh", "-c"]
