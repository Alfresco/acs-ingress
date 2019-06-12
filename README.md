# ACS Nginx Proxy

A proxy container for ACS Community deployment.

## Environment variables

| Name | Default | Description |
| --- | --- | --- |
| REPO_URL | `http://alfresco:8080` | Repository URL inside network. |
| SHARE_URL | `http://share:8080` | Share URL inside network. |
| ACCESS_LOG | n/a | Set the `access_log` value. Set to `off` to switch off logging. |

## Examples

```sh
docker run \
  -e REPO_URL="http://alfresco:8092" \
  -e SHARE_URL="http://share:8093" \
  -e ACCESS_LOG="off" \
  --rm -p 80:80/tcp \
  alfresco/acs-community-ngnix:1.0.0
```

Using with docker-compose:

```yml
digital-workspace-ingress:
    image: alfresco/acs-community-ngnix:1.0.0
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
    #     REPO_URL: "http://alfresco:8080"
    #     SHARE_URL: "http://share:8080"
```

## Continuous Integration

Bamboo branches:

* Repository / [ACS Ingress](https://bamboo.alfresco.com/bamboo/browse/PLAT-ACSING0)
