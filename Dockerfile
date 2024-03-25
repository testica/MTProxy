FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /MTProxy

COPY . .

RUN make

RUN mkdir -p /opt/MTProxy && \
    cp objs/bin/mtproto-proxy /opt/MTProxy/

RUN curl -s https://core.telegram.org/getProxySecret -o /opt/MTProxy/proxy-secret && \
    curl -s https://core.telegram.org/getProxyConfig -o /opt/MTProxy/proxy-multi.conf

RUN useradd -m -s /bin/false mtproxy && \
    chown -R mtproxy:mtproxy /opt/MTProxy

ENV PROXY_SECRETS ""
ENV PROXY_PORT "8888"
ENV PROXY_HTTP_PORT "8443"
ENV NUM_WORKERS "1"
ENV PUBLIC_IP ""
ENV PROXY_TAG ""

RUN chmod +x /MTProxy/entrypoint.sh

ENTRYPOINT ["/MTProxy/entrypoint.sh"]