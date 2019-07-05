# ACS Nginx Proxy

A proxy container for ACS deployment with Alfresco Digital Workspace support.

## Environment variables

| Name | Default | Description |
| --- | --- | --- |
| ADW_URL | `http://digital-workspace` | Digital Workspace URL inside network. |
| REPO_URL | `http://alfresco:8080` | Repository URL inside network. |
| SHARE_URL | `http://share:8080` | Share URL inside network. |
| SYNCSERVICE_URL | `http://sync-service:9090` | Sync service URL inside network. |
| ACCESS_LOG | n/a | Set the `access_log` value. Set to `off` to switch off logging. |

## Examples

```sh
docker run \
  -e ADW_URL="http://digital-workspace:8091" \
  -e REPO_URL="http://alfresco:8092" \
  -e SHARE_URL="http://share:8093" \
  -e SYNCSERVICE_URL="http://sync-service:9090" \
  -e ACCESS_LOG="off" \
  --rm -p 80:80/tcp \
  alfresco/alfresco-acs-nginx:3.0.1
```

Using with docker-compose:

```yml
digital-workspace:
    image: quay.io/alfresco/alfresco-digital-workspace:1.0.0

digital-workspace-ingress:
    image: alfresco/alfresco-acs-nginx:3.0.1
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

## Continuous Integration

Bamboo branches:

* Repository / [ACS Ingress](https://bamboo.alfresco.com/bamboo/browse/PLAT-ACSING)
