#!/bin/sh

if [[ "$DISABLE_SHARE" != "true" ]]; then
  sed -i s%\#SHARE_LOCATION%"location /share/ {\n            proxy_pass http://share:8080/;\n            absolute_redirect off;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ "$DISABLE_ADW" != "true" ]]; then
  sed -i s%\#ADW_LOCATION%"location /workspace/ {\n            proxy_pass http://digital-workspace:8080/;\n            absolute_redirect off;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ "$DISABLE_SYNCSERVICE" != "true" ]]; then
  sed -i s%\#SYNCSERVICE_LOCATION%"location /syncservice/ {\n            proxy_pass http://sync-service:9090/alfresco/;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ $ADW_URL ]]; then
  sed -i s%http:\/\/digital-workspace:8080%"$ADW_URL"%g /etc/nginx/nginx.conf
fi

if [[ $REPO_URL ]]; then
  sed -i s%http:\/\/alfresco:8080%"$REPO_URL"%g /etc/nginx/nginx.conf
fi

if [[ $SHARE_URL ]]; then
  sed -i s%http:\/\/share:8080%"$SHARE_URL"%g /etc/nginx/nginx.conf
fi

if [[ $SYNCSERVICE_URL ]]; then
  sed -i s%http:\/\/sync-service:9090%"$SYNCSERVICE_URL"%g /etc/nginx/nginx.conf
fi

if [[ $ACCESS_LOG ]]; then
  sed -i s%\#ENV_ACCESS_LOG%"access_log $ACCESS_LOG;"%g /etc/nginx/nginx.conf
fi

nginx -g "daemon off;"