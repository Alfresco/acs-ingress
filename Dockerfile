FROM nginx:stable-alpine
LABEL version="3.1.0"
LABEL maintainer="Denys Vuika <denys.vuika@alfresco.com>"

COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]