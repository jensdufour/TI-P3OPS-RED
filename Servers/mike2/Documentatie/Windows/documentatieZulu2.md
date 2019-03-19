## Werkwijze ##

Automatisatie bij PFSense is niet voor de hand liggend. De meest efficiënte manier om de firewall te installeren is door het opzetten van een reguliere PFSense installation. Daarna vervangen we de standaar .xml file met een voorafgemaakte .xml file met de juiste configuratie.
Dit is riskant want een enkele typfout doet alles falen. Het is dus aangeraden om de configuratie te doen via de officiele PHP shell of de onofficiële PHP API.

### Installatie PFSense ###

We gebruiken de laatste versie van PFSense. Deze kan je downloaden via volgende link:

* https://www.pfsense.org/download/

Binnen virtualbox maak je een nieuwe VM aan. We noemen deze PFSense.

![VM's](img/box1.JPG)

Bij de instellingen van de VM kiezen we voor 2 netwerkadapters. Beide zijn `intern netwerk`. Een zal dienen voor de WAN en de andere voor de LAN.

![Intern](img/intern.JPG)

![Extern](img/extern.JPG)

Nu starten we de pfSense server op en vervolledigen we de installatie.

![Copyright](img/copyright.JPG)

We kiezen eerst nog voor de installatie. Later zullen we alle instellingen doen via een .xml file.

![Installatie](img/installatie.JPG)

We kiezen voor een belgische keymap. Dit is natuurlijk een persoonlijke keuze.

![Keymap](img/belgiankeymap.JPG)

En we kiezen voor de guided installation. Dit is de laatste stap van de installatie.

![Auto](img/auto.JPG)

Nu zullen we de ip instellingen doen van de server zodat we toegang krijgen tot de webGUI via een andere pc.

Dit kunnen we doen via optie 2:

- WAN: 172.18.0.74 /30 + default-gateway: 172.18.0.73/30

- LAN: 172.18.0.69 /30

![Ip addressen](img/ipaddress.JPG)

Als we nu via een andere pc in het zelfde interne netwerk naar het adres 172.18.0.69 server dan komen we terecht op de webGUI van pfSense. We kunnen inloggen met de standaard username "admin" met als paswoord "pfsense".

![webGUI](img/webGUI.JPG)

Nu kunnen we via de tab "Diagnostics --> Backup and restore" de .xml file op de server plaatsen. Hierna gebeurt een reboot en is de firewall server klaar.

![Recovery](img/restoration.JPG)

## Handige Links ##

https://samuraihacks.com/install-pfsense-in-virtualbox/

https://www.ceos3c.com/pfsense/pfsense-2-4-installation-step-step-overview/
