#!/bin/sh

if [[ "$DISABLE_SHARE" != "true" ]]; then
  SHARE_HOST=$(echo "$SHARE_URL" | cut -d '/' -f 3)
  sed -i s%\#SHARE_UPSTREAM%"upstream share {\n        server ${SHARE_HOST};\n        keepalive 2;\n    }"%g /etc/nginx/nginx.conf
  SHARE_SCHEME=$(echo "$SHARE_URL" | grep -Eo '^https?://' || echo "http://")
  sed -i s%\#SHARE_LOCATION%"location /share/ {\n            proxy_pass ${SHARE_SCHEME}share;\n            absolute_redirect off;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ "$DISABLE_ADW" != "true" ]]; then
  ADW_HOST=$(echo "$ADW_URL" | cut -d '/' -f 3)
  sed -i s%\#ADW_UPSTREAM%"upstream digital-workspace {\n        server ${ADW_HOST};\n        keepalive 2;\n    }"%g /etc/nginx/nginx.conf
  ADW_SCHEME=$(echo "$ADW_URL" | grep -Eo '^https?://' || echo "http://")
  sed -i s%\#ADW_LOCATION%"location /workspace/ {\n            proxy_pass ${ADW_SCHEME}digital-workspace/;\n            absolute_redirect off;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ "$DISABLE_CONTROL_CENTER" != "true" ]]; then
  CONTROL_CENTER_HOST=$(echo "$CONTROL_CENTER_URL" | cut -d '/' -f 3)
  sed -i s%\#CONTROL_CENTER_UPSTREAM%"upstream control-center {\n        server ${CONTROL_CENTER_HOST};\n        keepalive 2;\n    }"%g /etc/nginx/nginx.conf
  CONTROL_CENTER_SCHEME=$(echo "$CONTROL_CENTER_URL" | grep -Eo '^https?://' || echo "http://")
  sed -i s%\#CONTROL_CENTER_LOCATION%"location /admin/ {\n            proxy_pass ${CONTROL_CENTER_SCHEME}control-center/;\n            absolute_redirect off;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ "$DISABLE_SYNCSERVICE" != "true" ]]; then
  SYNCSERVICE_HOST=$(echo "$SYNCSERVICE_URL" | cut -d '/' -f 3)
  sed -i s%\#SYNCSERVICE_UPSTREAM%"upstream sync-service {\n        server ${SYNCSERVICE_HOST};\n        keepalive 2;\n    }"%g /etc/nginx/nginx.conf
  SYNCSERVICE_SCHEME=$(echo "$SYNCSERVICE_URL" | grep -Eo '^https?://' || echo "http://")
  sed -i s%\#SYNCSERVICE_LOCATION%"location /syncservice/ {\n            proxy_pass ${SYNCSERVICE_SCHEME}sync-service/alfresco/;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ "$DISABLE_PROMETHEUS" != "true" ]]; then
  sed -i s%\#PROMETHEUS_LOCATION%"location ~ ^(/.*/s/prometheus)$ {return 403;}"%g /etc/nginx/nginx.conf
fi

if [[ "$ENABLE_CONTENT_APP" == "true" ]]; then
  CONTENT_APP_HOST=$(echo "$ADW_URL" | cut -d '/' -f 3)
  sed -i s%\#ACA_UPSTREAM%"upstream content-app {\n        server ${CONTENT_APP_HOST};\n        keepalive 2;\n    }"%g /etc/nginx/nginx.conf
  CONTENT_APP_SCHEME=$(echo "$ACA_URL" | grep -Eo '^https?://' || echo "http://")
  sed -i s%\#ACA_LOCATION%"location /content-app/ {\n            proxy_pass ${CONTENT_APP_SCHEME}content-app/;\n            absolute_redirect off;\n        }"%g /etc/nginx/nginx.conf
fi

if [[ $REPO_URL ]]; then
  REPO_HOST=$(echo "$REPO_URL" | cut -d '/' -f 3)
  sed -i s%alfresco:8080%"$REPO_HOST"%g /etc/nginx/nginx.conf
  REPO_SCHEME=$(echo "$REPO_URL" | grep -Eo '^https?://' || echo "http://")
  sed -i s%http:\/\/alfresco%"${REPO_SCHEME}alfresco"%g /etc/nginx/nginx.conf
fi

if [[ $ACCESS_LOG ]]; then
  sed -i s%\#ENV_ACCESS_LOG%"access_log $ACCESS_LOG;"%g /etc/nginx/nginx.conf
fi

if [[ $USE_SSL == "true" ]]; then
  sed -ie "s%\*:8080%443 ssl%g" /etc/nginx/nginx.conf
  sed -ie "/443 ssl/a\\\tserver_name $DOMAIN;" /etc/nginx/nginx.conf
  sed -ie "/server_name/a\\\tssl_certificate /etc/nginx/ssl/cert.crt;" /etc/nginx/nginx.conf
  sed -ie "/server_name/a\\\tssl_certificate_key /etc/nginx/ssl/cert.key;"      /etc/nginx/nginx.conf
fi


nginx -g "daemon off;"
