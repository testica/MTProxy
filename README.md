# MTProxy
Functional and dockerized MT-Proto proxy

## Docker
### Build
```bash
docker build . -t mtproxy
```
### Run
```bash
docker run --rm --name mtproxy \
    -e PROXY_SECRETS="<your_secret>" \
    -p 8443:8443 \
    mtproxy
```
#### Params
- **PROXY_SECRETS**

    A secret is a 16-byte in hex mode.
    ```bash
    head -c 16 /dev/urandom | xxd -ps
    ``` 
    You can pass multiple secrets
    ```
    -e PROXY_SECRETS="<your_secret1> <your_secret2>"
    ```
- **PROXY_HTTP_PORT** _(optional)_

    Port used by clients to connect to proxy. By default 8443
    
    Remember to publish the port outside docker `-p 8443:8443`
- **PROXY_TAG** _(optional)_

    Set receive tag from [@MTProxybot](https://t.me/MTProxybot) on Telegram
- **PUBLIC_IP** _(optional)_
    Your public IP, by default, is inferred by ipinfo.io
- **NUM_WORKERS** _(optional)_

    Number of workers from 1 to 256. By default 1


## Random padding
Due to some ISPs detecting MTProxy by packet sizes, random padding is
added to packets if such mode is enabled.

It's only enabled for clients which request it.

Add `dd` prefix to secret (`cafe...babe` => `ddcafe...babe`) to enable
this mode on client side.

## Connect to proxy
Using the following URI you can connect to your proxy directly
```
tg://proxy?server=<your_public_ip>&port=8443&secret=<your_secret>
```