# VLANs

Er zijn 5 VLANs voorzien in ons netwerk.

- VLAN 200 voor PC5-9. 
- VLAN 300 voor de private servers
- VLAN 400 voor communicatie tussen Switch5 & Switch6
- VLAN 500 voor de publieke servers
- VLAN 600 voor communicatie tussen Switch6 en Router1
- VLAN 999 dient als native VLAN. 


# Subnetting

Dit is de netwerkopdeling van het 172.18.0.0/16 netwerk toegekend aan Team Red.

| Netwerkadres | Decimaal subnetmasker | CIDR subnetmasker | Gebruikt in VLAN | Useable IP's
| - | - | - | - | - |
| 172.18.0.0 | 255.255.255.224 | /27 | 300 | 30
| 172.18.0.32 | 255.255.255.224 | /27 | 500 | 30
| 172.18.0.64 | 255.255.255.252 | /30 | 400| 2
| 172.18.0.68 | 255.255.255.252 | /30 | 600 | 2
| 172.18.2.0 | 255.255.255.128 | /25 | 200 | 126

De useable IP's tonen aan dat onze subnets zeker en vast futureproof zijn.

Voor de routering tussen Router0-4 hebben we gekozen voor de TEST-NET block, 192.0.2.0/24. 

| Netwerkadres | Decimaal subnetmasker | CIDR subnetmasker |  Useable IP's
| - | - | - | - |
| 192.0.2.0 | 255.255.255.252 | /30 | 2
| 192.0.2.4 | 255.255.255.252 | /30 | 2
| 192.0.2.8 | 255.255.255.252 | /30 | 2
| 192.0.2.12 | 255.255.255.252 | /30 | 2
| 192.0.2.16 | 255.255.255.252 | /30 | 2
# IP-allocatie

We bekijken de ip-allocatie per subnet.

        172.18.2.0/25

| Device | Interface | IP | Default Gateway
| - | - | - | - |
| Switch5 | G0/2 | 172.18.2.1/25
Andere IP addressen worden verdeeld via DHCP.

        172.18.0.0/27

| Device | Interface | IP | Default Gateway
| - | - | - | - |
| Switch5 | VLAN300 | 172.18.0.1/27
| Kilo2 | NIC | 172.18.0.2/27 | 172.18.0.1
| Lima2 | NIC | 172.18.0.3/27 | 172.18.0.1
| Mike2 | NIC | 172.18.0.4/27 | 172.18.0.1
| November2 | NIC | 172.18.0.5/27 | 172.18.0.1
| Oscar2 | NIC | 172.18.0.6/27 | 172.18.0.1
| Papa2 | NIC | 172.18.0.7/27 | 172.18.0.1
        172.18.0.32/27

| Device | Interface | IP | Default Gateway
| - | - | - | - |
| Switch6 | VLAN500 (F0/1) | 172.18.0.33/27
| Alfa2 | NIC | 172.18.0.34/27 | 172.18.0.33
| Bravo2 | NIC | 172.18.0.35/27 | 172.18.0.33
| Charlie2 | NIC | 172.18.0.36/27 | 172.18.0.33
| Delta2 | NIC | 172.18.0.37/27 | 172.18.0.33

        172.18.0.64/30
        
| Device | Interface | IP | 
| - | - | - | 
| Switch6 | G0/2 |  172.18.0.65/30
| Switch5 | G0/1 |  172.18.0.66/30

        172.18.0.68/30
        
| Device | Interface | IP | 
| - | - | - | 
| Router1 | G0/0/1 |  172.18.0.69/30
| Switch6 | G0/1 |  172.18.0.70/30


        192.0.2.0/30 
        
| Device | Interface | IP | 
| - | - | - | 
| Router2 | G0/0/1 |  192.0.2.1/30
| Router0 |  G0/0/0 |  192.0.2.2/30

        192.0.2.4/30 
        
| Device | Interface | IP | 
| - | - | - | 
| Router3 | G0/0/1 |  192.0.2.5/30
| Router1 |  G0/0/0 |  192.0.2.6/30

        192.0.2.8/30 
        
| Device | Interface | IP | 
| - | - | - | 
| Router2 | SE0/1/1 |  192.0.2.9/30
| Router3 |  SE0/1/0 |  192.0.2.10/30

        192.0.2.12/30 
        
| Device | Interface | IP | 
| - | - | - | 
| Router4 | SE0/1/0 |  192.0.2.13/30
| Router2 | SE0/1/0 |  192.0.2.14/30

        192.0.2.16/30 
        
| Device | Interface | IP | 
| - | - | - | 
| Router4 | SE0/1/1 |  192.0.2.17/30
| Router3 | SE0/1/1 |  192.0.2.18/30
