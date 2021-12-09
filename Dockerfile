FROM alpine:3.14.3

RUN apk update && \
    apk add nginx=1.20.2-r0 --no-cache && \
    mkdir -p /opt/www && chown nginx:nginx /opt/www && chmod 750 /opt/www && umask 077

COPY --chown=nginx:nginx index.html /opt/www
COPY  nginx.conf /etc/nginx/http.d

USER nginx

EXPOSE 8080

CMD [ "/usr/sbin/nginx", "-g", "daemon off;"]
