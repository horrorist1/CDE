# **CDE** Server setup

### Request software

Additional software packages need to be installed:

- docker
- docker-compose

### Configurations

#### Proxy

To allow `docker` to interact with outer world you need to configure your proxies in
`/etc/systemd/system/docker.service.d/http-proxy.conf`.
The content of the file should be similar to the following:

```shell
Environment="HTTP_PROXY=http://your-proxy.net
Environment="HTTPS_PROXY=http://your-proxy.net
Environment="NO_PROXY=localhost,10.0.0.0/8
```
