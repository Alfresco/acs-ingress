# ACS Nginx Proxy

A proxy container for ACS deployment with Alfresco Digital Workspace and Sync Service support. If USE_SSL set to true provide ssl cert in ssl/cert.crt and ssl/cert.key

## Environment variables

| Name | Default | Description |
| --- | --- | --- |
| REPO_URL | `http://alfresco:8080` | Repository URL inside network. |
| ADW_URL | `http://digital-workspace` | Digital Workspace URL inside network. |
| SHARE_URL | `http://share:8080` | Share URL inside network. |
| SYNCSERVICE_URL | `http://sync-service:9090` | Sync service URL inside network. |
| DISABLE_ADW | `false` | Disables ADW if set to `"true"` |
| DISABLE_SHARE | `false` | Disables Share if set to `"true"` |
| DISABLE_SYNCSERVICE | `false` | Disables Sync Service if set to `"true"` |
| DISABLE_PROMETHEUS | `false` | Disables Prometheus if set to `"true"` |
| ACCESS_LOG | n/a | Set the `access_log` value. Set to `off` to switch off logging. |
| USE_SSL | `false` | Enables ssl use if set to `"true"` |
| DOMAIN | n/a | Set domain value for ssl certificate |

## Examples

```sh
docker run \
  -e ADW_URL="http://digital-workspace:8091" \
  -e REPO_URL="http://alfresco:8092" \
  -e SHARE_URL="http://share:8093" \
  -e SYNCSERVICE_URL="http://sync-service:9090" \
  -e ACCESS_LOG="off" \
  -e USE_SSL="true" \
  -e DOMAIN="domain.com" \ # when USE_SSL="true"
  -v ssl/:/etc/nginx/ssl/ \ # when USE_SSL="true"
  --rm -p 443:443/tcp \ # when USE_SSL="true" | default 8080:8080
  alfresco/alfresco-acs-nginx:3.2.0
```

Using with docker-compose:

```yml
digital-workspace:
    image: quay.io/alfresco/alfresco-digital-workspace:1.0.0

digital-workspace-ingress:
    image: alfresco/alfresco-acs-nginx:3.1.0
    depends_on:
        - alfresco
        - digital-workspace
    ports:
        - 443:443 # when USE_SSL="true"
#        - 8080:8080 #default
    links:
        - digital-workspace
        - alfresco
        - share
    volumes:
       - ${PWD}/ssl/:/etc/nginx/ssl/ # when USE_SSL="true"
    environment:
        USE_SSL: "true"
        DOMAIN: "domain.com" # when USE_SSL="true"
    #     ADW_URL: "http://digital-workspace"
    #     REPO_URL: "http://alfresco:8080"
    #     SHARE_URL: "http://share:8080"
    #     SYNCSERVICE_URL: "http://sync-service:9090"
```

Using with docker-compose Community deployment:

```yml
proxy:
    image: alfresco/alfresco-acs-nginx:3.1.0
    mem_limit: 128m
    environment:
        DISABLE_PROMETHEUS: "true"
        DISABLE_SYNCSERVICE: "true"
        DISABLE_ADW: "true"
        USE_SSL: "true" #
        DOMAIN: "domain.com" # when USE_SSL="true"
    depends_on:
        - alfresco
    ports:
        - 443:443 # when USE_SSL="true"
#        - 8080:8080 # default
    links:
        - alfresco
        - share
    volumes:
       - ${PWD}/ssl/:/etc/nginx/ssl/ # when USE_SSL="true"
```

## Continuous Integration

[Travis build](https://travis-ci.com/github/Alfresco/acs-ingress)
