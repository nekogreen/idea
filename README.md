# IntelliJ

IntelliJ Settings

- Editor > Color Scheme > Java > Method call
- Editor > Color Scheme > Java > Static method
- Plugins > CamelCase
- Plugins > Frame Switcher

# Favorite Commands

## awk

```shell
awk -F'(foo|bar)' '{print $2; fflush()}'
```

## curl

```shell
curl -c cookie.txt -b cookie.txt -w "http_code=%{http_code}, time_total=%{time_total}\n" https://ifconfig.io
```

## date

```shell
date "+%Y-%m-%d %H:%M:%S"
```

```shell
date --date "1 day ago" "+%Y-%m-%d %H:%M:%S"
```

## dig

```shell
dig +short ifconfig.io
```

## find

```shell
find ./ -type f -mmin -10 -name "newer-than-10-minutes-ago"
```

```shell
find ./ -type f -daystart -mtime +0 -name "older-than-today"
```

## Go

#### error message

```shell
return nil, fmt.Errorf("failed to foo (bar=%v): %w", bar, err)
```

## grep

```shell
grep --line-buffered -E '(^|\W)(foo)($|\W)' bar.txt
```

```shell
grep --line-buffered -Er '(^|\W)(foo)($|\W)' ./ --exclude-dir=.git
```

```shell
grep --line-buffered -Er '(^|\W)(foo)($|\W)' ./ --exclude-dir={.git,.idea}
```

## gunzip

```shell
find /home/ec2-user/foo -name '*.gz' -print0 | xargs -0 -n1 gunzip
```

## httpd

#### change color for each status

```shell
tail -F /var/log/httpd/access_log | perl -pe 's;(" )([0-9])([0-9]{2})( );\1\e[3\2m\2\3\e[m\4;'
```

## Jenkins

#### find raw settings

```shell
for CONFIG_PATH in $(find /var/lib/jenkins/jobs/ -maxdepth 2 -name "config.xml" | sort); do RESULT=$(grep 'foo' "${CONFIG_PATH}") && echo "${CONFIG_PATH}" "${RESULT}"; done
```

#### open all advanced settings

```js
const buttons = document.getElementsByTagName('button');
for (let i = 0; i < buttons.length; i++) {
    if (buttons[i].textContent === 'Advanced...') {
        buttons[i].click();
    }
}
```

## jq

```shell
jq . --unbuffered foo.json
```

## kubectl

```shell
kubectl describe foo
```

## ln

```shell
sudo ln -nfs /home/ec2-user/sh/foo.sh /usr/local/bin/foo
```

## mvn

```shell
mvn dependency:tree
```

```shell
mvn clean compile -U
```

## mysql

```shell
mysql -uroot -e "show variables like '%char%'";
```

```shell
mysql -uroot -e "show variables like '%connections%'";
```

```shell
mysql -uroot -e "show grants for 'root'@'localhost'";
```

## Null Device

```shell
>/dev/null
```

## perl

```shell
perl -pe "$|=1;s;foo;baz;g" baz.txt
```

## ps

```shell
ps aux | grep -Ev "^$(id -un)" | grep foo
```

## rpm

```shell
rpm -qa | grep foo
```

```shell
rpm -qs foo
```

## scp

```shell
scp host:/home/ec2-user/foo/* ./
```

## ssh-keygen

```shell
ssh-keygen -t rsa -b 4096 -C "foo"
```

## tee

```shell
2>&1 | tee ~/foo.txt
```

## Tomcat

#### change color of important messages

```shell
tail -F /var/log/tomcat/catalina.out | perl -pe "s;^(.*(^|\W)(WARN|WARNING|ERROR|SEVERE|Server startup|shutdown)($|\W).*)$;\e[31m\1\e[m;i"
```

#### find important messages

```shell
tail -F /var/log/tomcat/catalina.out | grep -E "^(.*(^|\W)(WARN|WARNING|ERROR|SEVERE|Server startup|shutdown)($|\W).*)$" --color=always --line-buffered -A1
```

# Favorite Commands On OSX

## tcpdump

```shell
sudo tcpdump -i pktap,lo -s0 -An \(port 80 or port 8080 or port 8000 or port 8081\) and greater 128
```

# Server Performance Tuning

## File descriptor

```shell
for P in httpd java mysql; do
  PIDS=$(pgrep ${P}) && for PID in ${PIDS}; do
    printf '%s\t%s\t%s\n' "${P}" "${PID}" "$(grep 'open' "/proc/${PID}/limits")"
  done
done
```

## Port range and keepalive

```shell
sudo sysctl -a | grep -E 'keepalive|port_range'
```
