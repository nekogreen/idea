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

## find

```shell
find . -type f -mmin -10 -name "only-last-10-minutes"
```

## go

```shell
return nil, fmt.Errorf("failed to xxx (yyy=%v): %w", yyy, err)
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

# Favorite Commands On OSX

## i2cssh

```shell
i2cssh -p"PROFILE" -l"LOGIN" -C1 -m"MACHINE,MACHINE,MACHINE"
```

## tcpdump

```shell
sudo tcpdump -i pktap,lo -s0 -An \(port 80 or port 8080 or port 8000 or port 8081\) and greater 128
```

# Server Performance Tuning

## File descriptor

```shell
for P in httpd java mysql; do
  PIDS=$(pgrep $P) && for PID in $PIDS; do
    printf '%s\t%s\t%s\n' "$P" "$PID" "$(grep 'open' "/proc/$PID/limits")"
  done
done
```

## Port range and keepalive

```shell
sudo sysctl -a | grep -E 'keepalive|port_range'
```
