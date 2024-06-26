FROM alpine:3.20

ENV SQUID_CONFIG_FILE /etc/squid/squid.conf
ENV TZ Europe/Moscow

RUN set -x && \
  apk update && \
  apk add squid && \
  rm -f /var/cache/apk/*;

VOLUME ["/var/cache/squid"]
EXPOSE 3128/tcp

CMD ["sh", "-c", "/usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -z && exec /usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -YCd 1"]
