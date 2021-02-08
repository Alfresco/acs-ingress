# ACS Nginx Proxy

A proxy container for ACS deployment with Alfresco Digital Workspace and Sync Service support.

## Environment variables

| Name | Default | Description |
| --- | --- | --- |
| ADW_URL | `http://digital-workspace` | Digital Workspace URL inside network. |
| REPO_URL | `http://alfresco:8080` | Repository URL inside network. |
| SHARE_URL | `http://share:8080` | Share URL inside network. |
| SYNCSERVICE_URL | `http://sync-service:9090` | Sync service URL inside network. |
| ACCESS_LOG | n/a | Set the `access_log` value. Set to `off` to switch off logging. |
| DISABLE_ADW | `false` | Disables ADW if set to `"true"` |
| DISABLE_SYNCSERVICE | `false` | Disables Sync Service if set to `"true"` |

## Examples

```sh
docker run \
  -e ADW_URL="http://digital-workspace:8091" \
  -e REPO_URL="http://alfresco:8092" \
  -e SHARE_URL="http://share:8093" \
  -e SYNCSERVICE_URL="http://sync-service:9090" \
  -e ACCESS_LOG="off" \
  --rm -p 80:80/tcp \
  alfresco/alfresco-acs-nginx:3.1.0
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
        - 8080:8080
    links:
        - digital-workspace
        - alfresco
        - share
    # environment:
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
        DISABLE_SYNCSERVICE: "true"
        DISABLE_ADW: "true"
    depends_on:
        - alfresco
    ports:
        - 8080:8080
    links:
        - alfresco
        - share
```

## Continuous Integration

[Travis build](https://travis-ci.com/github/Alfresco/acs-ingress)
