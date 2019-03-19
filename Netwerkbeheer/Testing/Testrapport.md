# Testrapport Fysiek Netwerk

Auteur(s) testrapport: Thor Nicolaï

# Precondities

 * VMWare Workstation Pro is geïnstalleerd
 * U bent verbonden met het klasnetwerk
 * De VMWare ESXi server draait
 * Alle servers draaien
 * De hosts zijn aangesloten op Switch4.
 * Kilo2/Kilo1 least DHCP-addressen
 * De routers en switches zijn geconfigureerd

# Testing

### Inloggen op ESXi server - Alfa2
login: root
wachtwoord: Esxtest1

![enter image description here](https://i.imgur.com/rZ4XfsK.png) Succes!

### Vlan 500

Deze pings worden uitgevoerd op Alfa2.

 - [x]  Ping naar 172.18.0.2

![](https://i.imgur.com/N3wBEl6.png)
 - [x]  Ping naar 172.18.0.35

![](https://i.imgur.com/eYzPZ8W.png)

 - [x]  Ping naar 172.18.2.1

![](https://i.imgur.com/adXlfMJ.png)

 - [x]   Ping naar 172.16.0.3

![enter image description here](https://i.imgur.com/jZC2be9.png)

 - [x]   Ping naar 172.16.0.34

![](https://i.imgur.com/lTpmXcI.png)

 - [x]  Ping naar 172.16.1.2

![enter image description here](https://i.imgur.com/Gh2IeEl.png)

### Vlan 300 

Deze pings worden uitgevoerd op Kilo2, deze staat lokaal op Mathias Meyfroidt zijn laptop.

 - [x]  Ping naar 172.18.0.2

![](https://i.imgur.com/N3wBEl6.png)
 - [x]  Ping naar 172.18.0.34

![](https://i.imgur.com/QhbGVWq.png)

 - [x]  Ping naar 172.18.2.1

![](https://i.imgur.com/adXlfMJ.png)

 - [x]   Ping naar 172.16.0.3

![enter image description here](https://i.imgur.com/jZC2be9.png)

 - [x]   Ping naar 172.16.0.34

![](https://i.imgur.com/lTpmXcI.png)

 - [x]  Ping naar 172.16.1.2

![enter image description here](https://i.imgur.com/Gh2IeEl.png)

### Vlan 200

 - [x]  Ping naar 172.18.0.2

![enter image description here](https://i.imgur.com/ECxYhAR.png)

 - [x]  Ping naar 172.18.0.35

![](https://i.imgur.com/PaAjtCD.png)

 - [x]  Ping naar 172.18.2.1

![](https://i.imgur.com/TBPipo4.png)

 - [x]   Ping naar 172.16.0.3

![enter image description here](https://i.imgur.com/v9WoiWJ.png)

 - [x]   Ping naar 172.16.0.34

![enter image description here](https://i.imgur.com/C1bIfQ2.png)

 - [x]  Ping naar 172.16.1.2

![enter image description here](https://i.imgur.com/OtM6ewJ.png)


