FROM alpine:latest

LABEL maintainer="klgd <slice1213@gmail.com>"

WORKDIR /app

ENV RPC_SECRET=""
ENV ENABLE_AUTH=false
ENV ARIA2_USER=user
ENV ARIA2_PWD=password

RUN apk update \
	&& apk add --no-cache --update aria2 make musl-dev gcc \
	&& mkdir -p aria2-ng \
    && version=1.1.3 \
    && wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}.zip \
    && unzip AriaNg-${version}.zip -d aria2-ng \
    && rm -rf AriaNg-${version}.zip \
    && chmod -R 755 aria2-ng \
    && wget --no-check-certificate https://github.com/ryanmjacobs/darkhttpd/archive/r2.zip \
    && unzip r2.zip \
    && rm -rf r2.zip \
    && ( \
        cd darkhttpd-r2 \
        && make bin \
        && make install \
    ) \
    && rm -rf darkhttpd-r2 \
    && apk del make musl-dev gcc

ADD start.sh /app/
ADD conf /app/conf

RUN chmod +x /app/start.sh

VOLUME ["/app/conf", "/data"]
EXPOSE 6800 6080

CMD ["/app/start.sh"]