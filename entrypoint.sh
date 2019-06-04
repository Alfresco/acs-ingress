#!/bin/sh

if [[ $ADW_URL ]]; then
  sed -i s%http:\/\/digital-workspace:8080%"$ADW_URL"%g /etc/nginx/nginx.conf
fi

if [[ $REPO_URL ]]; then
  sed -i s%http:\/\/alfresco:8080%"$REPO_URL"%g /etc/nginx/nginx.conf
fi

if [[ $SHARE_URL ]]; then
  sed -i s%http:\/\/share:8080%"$SHARE_URL"%g /etc/nginx/nginx.conf
fi

if [[ $ACCESS_LOG ]]; then
  sed -i s%\#ENV_ACCESS_LOG%"access_log $ACCESS_LOG;"%g /etc/nginx/nginx.conf
fi

nginx -g "daemon off;"