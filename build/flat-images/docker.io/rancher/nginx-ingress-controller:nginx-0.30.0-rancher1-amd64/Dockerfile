FROM scratch
ADD flattened.tar.xz /
LABEL org.opencontainers.image.documentation="https://kubernetes.github.io/ingress-nginx/"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.source="https://github.com/kubernetes/ingress-nginx"
LABEL org.opencontainers.image.title="NGINX Ingress Controller for Kubernetes"
LABEL org.opencontainers.image.vendor="The Kubernetes Authors"
LABEL org.opencontainers.image.version="nginx-0.30.0-rancher1"
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/luajit/bin:/usr/local/nginx/sbin:/usr/local/nginx/bin
ENV LUA_PATH=/usr/local/share/luajit-2.1.0-beta3/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/lib/lua/?.lua;;
ENV LUA_CPATH=/usr/local/lib/lua/?/?.so;/usr/local/lib/lua/?.so;;
USER www-data
WORKDIR /etc/nginx
CMD ["/nginx-ingress-controller"]
ENTRYPOINT ["/usr/bin/dumb-init","--"]
