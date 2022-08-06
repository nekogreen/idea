# IntelliJ

IntelliJ Settings

- Editor > Color Scheme > Java Method call
- Plugins > CamelCase

# Favorite Commands

## awk
```shell
awk -F'(xxx|yyy)' '{print $2; fflush()}'
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

## jq
```shell
jq . --unbuffered yyy.json
```

## kubectl
```shell
kubectl describe xxx
```

## mvn
```shell
mvn dependency:tree
```
```shell
mvn clean compile -U
```

## perl
```shell
perl -pe "$|=1;s;xxx;zzz;g" yyy.txt
```

# Favorite one liner

## File descriptor
```shell
for P in httpd java mysql; do
  PIDS=$(pgrep $P) && for PID in $PIDS; do
    printf "%s\t%s\t%s\n" "$P" "$PID" "$(grep 'open' "/proc/$PID/limits")"
  done
done
```
