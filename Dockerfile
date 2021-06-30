FROM nginx:stable-alpine
LABEL version="3.2.0"
LABEL maintainer="Denys Vuika <denys.vuika@alfresco.com>"

EXPOSE 8080

COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]