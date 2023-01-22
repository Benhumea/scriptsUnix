
```sh
for ip in $(seq 1 254); do

    ping -c 1 192.168.2.$ip| grep "bytes from"&

done
```

```sh
ping -c 5 -b 192.168.2.254 | grep 'bytes from' | awk '{ print $4 }' | sort | uniq
```