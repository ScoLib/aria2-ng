FROM alpine:latest

LABEL maintainer="klgd <slice1213@gmail.com>"

WORKDIR /app

ENV RPC_SECRET=""
ENV ARIA2_USER=user
ENV ARIA2_PWD=password

RUN apk update \
	&& apk add --no-cache --update aria2 bash curl \
    && curl https://getcaddy.com | bash -s personal \
	&& mkdir -p ariang \
    && version=1.1.4 \
    && wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}.zip \
    && unzip AriaNg-${version}.zip -d ariang \
    && rm -rf AriaNg-${version}.zip \
    && chmod -R 755 ariang \
    && sed -i 's/6800/80/g' /app/ariang/js/aria-ng*.js

ADD start.sh /app/
ADD conf /app/conf
ADD Caddyfile /usr/local/caddy/

RUN chmod +x /app/start.sh

VOLUME ["/app/conf", "/data"]
EXPOSE 80

CMD ["/app/start.sh"]