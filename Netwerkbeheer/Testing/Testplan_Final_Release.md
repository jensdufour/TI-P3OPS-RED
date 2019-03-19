# Testplan Fysiek Netwerk

Auteur(s) testplan: Tommy Veevaete

# Preconditie
 * VMWare Workstation Pro is geïnstalleerd
 * U bent verbonden met het klasnetwerk
 * De VMWare ESXi server draait
 * Alle servers draaien
 * De hosts zijn aangesloten op Switch4.
 * Kilo2/Kilo1 least DHCP-addressen
 * De routers en switches zijn geconfigureerd

# Postconditie
 * Een Host krijgt een DHCP-adres van Kilo2/Kilo1.
 * Er is connectiviteit tussen het Linux en het Windows netwerk
 * Er is connectiviteit binnen het Windows netwerk
     
# Test

Druk in VMWare Workstation op `CTRL+L`. Connecteer naar `172.22.2.4`met 'Username' `root` en 'Password' `Esxtest1`.
### VLAN 500
Open Alfa2. Druk op `Windows + X` en selecteer 'Command Prompt'. Voer volgende commando's uit:
```
ping 172.18.0.2
ping 172.18.0.35
ping 172.18.2.1
ping 172.16.0.3
ping 172.16.0.34
ping 172.16.1.2
```
Als alle pings geslaagd zijn, dan is er volledige connectiviteit tussen VLAN 500 en het volledige Windows en Linux domein.

Open Internet Explorer en surf naar `https://www.google.be`. Als de pagina laadt, dan is er connectiviteit met het internet.

### VLAN 300
Open Kilo2. Druk op `Windows + X` en selecteer 'Command Prompt'. Voer volgende commando's uit:
```
ping 172.18.0.2
ping 172.18.0.34
ping 172.18.2.1
ping 172.16.0.3
ping 172.16.0.34
ping 172.16.1.2
```
Als alle pings geslaagd zijn, dan is er volledige connectiviteit tussen VLAN 300 en het volledige Windows en Linux domein.

### VLAN 200
Open Een host-pc. Druk op `Windows + X` en selecteer 'Command Prompt'. Voer volgende commando's uit:
```
ping 172.18.0.2
ping 172.18.0.34
ping 172.18.2.1
ping 172.16.0.3
ping 172.16.0.34
ping 172.16.1.2
```
Als alle pings geslaagd zijn, dan is er volledige connectiviteit tussen VLAN 200 en het volledige Windows en Linux domein.
