# Environment Preparation

## Setting proxies

Set proxies for your  shell by adding the following lines to your `~/.bashrc`.

```bash
[username@hostname ~]$ export https_proxy=http://your-proxy.com
[username@hostname ~]$ export http_proxy=http://your-proxy.com
[username@hostname ~]$ export no_proxy=localhost,127.0.0.0,127.0.1.1
```

Source `~/.bashrc` afterwards:

```bash
[username@hostname ~]$ . ~/.bashrc
```
