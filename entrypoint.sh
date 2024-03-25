#!/bin/bash

COMMAND="/opt/MTProxy/mtproto-proxy"
ARGS="-u mtproxy -p $PROXY_PORT -H $PROXY_HTTP_PORT"

if [ -n "$PROXY_SECRETS" ]; then
    ARGS+=" $(echo $PROXY_SECRETS | sed 's/[^ ]*/-S &/g')"
fi

ARGS+=" --aes-pwd /opt/MTProxy/proxy-secret"

ARGS+=" /opt/MTProxy/proxy-multi.conf"

ARGS+=" --nat-info $(hostname --ip-address):$(echo ${PUBLIC_IP:=$(curl -s ipinfo.io/ip)})"

if [ -n "$PROXY_TAG" ]; then
    ARGS+=" -P $PROXY_TAG"
fi

ARGS+=" -M $NUM_WORKERS"

exec $COMMAND $ARGS