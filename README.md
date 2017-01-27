# Shutdown Linux for Power Outages

## Prerequisite

It is required that server be connected to nobreak

## Install

```sh
$ sudo curl -L "https://raw.githubusercontent.com/00F100/nobreak-shutdown-linux/master/nobreak.sh" -o /usr/local/bin/nobreak
$ sudo chmod +x /usr/local/bin/nobreak
```

## Usage

```sh
$ nobreak [string - DOMAIN OR IP] [int - NUM OF PING CALLS] [int - NUM OF PINGS CALL ERROR LOG] [int - TIME IN SECONDS TO DELAY BEFORE SHUTDOWN SERVER] [int - TIME IN MINUTES TO DELAY BEFORE SHUTDOWN SERVER]
```

## Configure on Crontab

```sh
*/2 * * * * root nobreak google.com 6 3 600 10
```

## Example Sucess, has power!

```sh
$ nobreak google.com 6 3 600 10
```

#### Logs

```sh
$ cat /var/log/nobreak.log
2:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=1 ttl=42 time=156 ms
3:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=2 ttl=42 time=156 ms
4:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=3 ttl=42 time=156 ms
5:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=4 ttl=42 time=155 ms
6:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=5 ttl=42 time=155 ms
7:64 bytes from vl-in-f101.1e100.net (74.125.141.101): icmp_seq=6 ttl=42 time=156 ms
```

## Example Power Fail, shutdown! (External server)

```sh
$ nobreak google.com 6 3 600 10
The power is gone away
Sleep 10 minnutes
Try connect host...
The power do not return after 10 minutes, turn off server
```

## Example Power Fail, shutdown! (Local network)

```sh

# POWER PLANT

If power down, servers have nobreak, router no! The ping need stop and shutdown server!

| POWER |
	=> | NOBREAK |
		=> | SERVER 1 |
		=> | SERVER 2 |
------------------------------------------------------
| POWER |
	=> | ROUTER |


# NETWORK PLANT

| Internet | => | ROUTER (192.168.1.1) |
						=> | SERVER 1 (192.168.1.2) |
						=> | SERVER 2 (192.168.1.3) |


# ON SERVER 1... ping SERVER 2 ...
$ nobreak 192.168.1.3 6 3 600 10

# ON SERVER 2... ping SERVER 1 ...
$ nobreak 192.168.1.2 6 3 600 10
```

#### Logs
```sh
$ cat /var/log/nobreak-fail.log
The power is gone away
26/01/2017 22:30:13 FAIL (ping 192.168.1.254)
PING 192.168.1.254 (192.168.1.254) 56(84) bytes of data.
From 192.168.1.253 icmp_seq=1 Destination Host Unreachable
From 192.168.1.253 icmp_seq=2 Destination Host Unreachable
From 192.168.1.253 icmp_seq=3 Destination Host Unreachable

--- 192.168.1.254 ping statistics ---
3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2016ms
pipe 3
-----------------------------------------------------------------------------------------------
Sleep 10 minutes
Try connect host...
-----------------------------------------------------------------------------------------------
PING 192.168.1.254 (192.168.1.254) 56(84) bytes of data.
From 192.168.1.253 icmp_seq=1 Destination Host Unreachable
From 192.168.1.253 icmp_seq=2 Destination Host Unreachable
From 192.168.1.253 icmp_seq=3 Destination Host Unreachable

--- 192.168.1.254 ping statistics ---
3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2016ms
pipe 3
-----------------------------------------------------------------------------------------------
The power do not return after 10 minutes, turn off server
```