FROM alpine:3.16.2
	
ENV SQUID_CONFIG_FILE /etc/squid/squid.conf
ENV TZ Europe/Moscow

RUN set -x && \
  apk update && \
  apk install squid && \
  rm -f /var/cache/apk/*; \
	deluser squid 2>/dev/null; delgroup squid 2>/dev/null; \
	addgroup -S squid -g 3128 && \
  adduser -S -u 3128 -G squid -g squid -H -D -s /bin/false -h /var/cache/squid squid

VOLUME ["/var/cache/squid"]	
EXPOSE 3128/tcp

USER squid

CMD ["sh", "-c", "/usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -z && exec /usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -YCd 1"]
