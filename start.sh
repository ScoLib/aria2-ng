#!/bin/sh

if [ -f /app/conf/on-complete.sh ]; then
	chmod +x /app/conf/on-complete.sh
fi

sed -i "s/#rpc-secret=token/rpc-secret=${RPC_SECRET}/g" /app/conf/aria2.conf

echo "Start darkhttpd"
if [ "$ENABLE_AUTH" = "true" ]; then
  # echo "auth: ${ARIA2_USER}:${ARIA2_PWD}"
  darkhttpd /app/aria2-ng --port 6080 --auth ${ARIA2_USER}:${ARIA2_PWD} &
else
  darkhttpd /app/aria2-ng --port 6080 &
fi

echo "Start aria2"
/usr/bin/aria2c --conf-path="/app/conf/aria2.conf" \
--enable-rpc --rpc-listen-all \
--rpc-secret="${RPC_SECRET}"