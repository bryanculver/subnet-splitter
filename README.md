# Subnet Splitter
A utility to assist in splitting a subnet into smaller subnets.

Currently only supports IPv4, which IPv6 hot on it's tail.

## Usage
```
$> subnet_split "172.16.0.0/24" 30

172.16.0.0  30  172.16.0.0/30
172.16.0.4  30  172.16.0.4/30
172.16.0.8  30  172.16.0.8/30
...
```