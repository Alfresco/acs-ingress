# ACS Nginx Proxy

A proxy container for ACS deployment with Alfresco Digital Workspace support.

## Environment variables

| Name | Default | Description |
| --- | --- | --- |
| ADW_URL | `http://digital-workspace` | Digital Workspace URL inside network. |
| REPO_URL | `http://alfresco:8080` | Repository URL inside network. |
| SHARE_URL | `http://share:8080` | Share URL inside network. |
| ACCESS_LOG | n/a | Set the `access_log` value. Set to `off` to switch off logging. |

## Examples

```sh
docker run \
  -e ADW_URL="http://digital-workspace:8091" \
  -e REPO_URL="http://alfresco:8092" \
  -e SHARE_URL="http://share:8093" \
  -e ACCESS_LOG="off" \
  --rm -p 80:80/tcp \
  quay.io/alfresco/alfresco-acs-nginx:1.0.0
```

Using with docker-compose:

```yml
digital-workspace:
    image: quay.io/alfresco/alfresco-digital-workspace:1.0.0

digital-workspace-ingress:
    image: quay.io/alfresco/alfresco-acs-nginx:1.0.0
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
```

## Continuous Integration

Bamboo branches:

* Alfresco Digital Workspace / [ACS Nginx Proxy](https://bamboo.alfresco.com/bamboo/browse/ADW-ANP)