# Shutdown Linux for Power Outages

## Install

```sh
$ sudo curl -L "https://raw.githubusercontent.com/00F100/nobreak-shutdown-linux/master/nobreak.sh" -o /usr/local/bin/nobreak
$ sudo chmod +x /usr/local/bin/nobreak
```

## usage

```sh
$ nobreak [string - DOMAIN OR IP] [int - NUM OF PING CALLS] [int - NUM OF PINGS CALL ERROR LOG] [int - TIME IN SECONDS TO DELAY BEFORE SHUTDOWN SERVER] [int - TIME IN MINUTES TO DELAY BEFORE SHUTDOWN SERVER]
```

## Example Sucess, has power!

```sh
$ nobreak google.com 6 3 600 10
```

```sh
$ cat /var/log/nobreak.log
2:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=1 ttl=42 time=156 ms
3:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=2 ttl=42 time=156 ms
4:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=3 ttl=42 time=156 ms
5:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=4 ttl=42 time=155 ms
6:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=5 ttl=42 time=155 ms
7:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=6 ttl=42 time=156 ms
```

## Example Power Fail, shutdown!

```sh
$ nobreak google.com 6 3 600 10
A ENERGIA CAIU!
SLEEP DE 10 MINUTOS
```

```sh
$ cat /var/log/nobreak-fail.log
A ENERGIA CAIU!
-----------------------------------------------------------------------------------------------
24/01/2017 03:54:01 - O SERVIDOR ANALISOU E DETECTOU QUEDA DE ENERGIA
----------------
24/01/2017 03:56:01 FAIL (ping 192.168.1.254)
PING 192.168.1.254 (192.168.1.254) 56(84) bytes of data.
From 192.168.1.253 icmp_seq=1 Destination Host Unreachable
From 192.168.1.253 icmp_seq=2 Destination Host Unreachable
From 192.168.1.253 icmp_seq=3 Destination Host Unreachable

--- 192.168.1.254 ping statistics ---
3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2016ms
pipe 3
A ENERGIA CAIU!
-----------------------------------------------------------------------------------------------
24/01/2017 03:56:01 - O SERVIDOR ANALISOU E DETECTOU QUEDA DE ENERGIA
A LUZ NAO RETORNOU EM 10 MINUTOS, DESLIGANDO SERVIDOR
```