## Ubuntu 18.04 and up

### iptables

```bash
sudo  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

### resolvconf

```bash
sudo apt update && sudo apt install resolvconf
# make edits
sudo service resolvconf restart
```
