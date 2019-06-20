FROM nginx:stable-alpine
LABEL version="1.0.0"
LABEL maintainer="Denys Vuika <denys.vuika@alfresco.com>"

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME [ "/etc/nginx/auth" ]

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
