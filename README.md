# IntelliJ

IntelliJ Settings

- Editor > Color Scheme > Java Method call
- Plugins > CamelCase

# Commands

## awk
```shell
awk -F'xxx|yyy' '{print $2; fflush()}'
```

## curl
```shell
curl -c cookie.txt -b cookie.txt -w "http_code=%{http_code}, time_total=%{time_total}\n" https://ifconfig.io
```

## date
```shell
date "+%Y-%m-%d %H:%M:%S"
```

## dig
```shell
dig +short ifconfig.io
```

## grep
```shell
grep --line-buffered -E '(^|\W)xxx($|\W)' yyy.txt
```
