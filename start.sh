#!/bin/bash -eu

chown -R aria2:aria2 \
         /app \
         /usr/local \
         /var/log

if [ -f /app/conf/on-complete.sh ]; then
	chmod +x /app/conf/on-complete.sh
fi

sed -i "s/#rpc-secret=token/rpc-secret=${RPC_SECRET}/g" /app/conf/aria2.conf

echo "Start Caddy"
/usr/local/bin/caddy -quic --conf /usr/local/caddy/Caddyfile &

echo "Start aria2c"
/usr/bin/aria2c --conf-path="/app/conf/aria2.conf" \
--enable-rpc --rpc-listen-all \
--rpc-secret="${RPC_SECRET}"