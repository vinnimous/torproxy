# torproxy
I wanted a very quick to boot and extremly simple way to anonymize activity without excessive complicated scripts.

## requirements
Requires exposure of port 9050 for socks and 8118 for privoxy

## testing
### Test privoxy
```
curl -x <<proxy>>:8118 https://check.torproject.org/api/ip
```
### Test tor
```
curl --socks5 <<proxy>>:9050 https://check.torproject.org/api/ip
```