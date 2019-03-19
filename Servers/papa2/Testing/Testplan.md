# Testplan PAPA2

Auteur(s) testplan: Sam Strobbe, Thor Nicolaï

# Preconditie

- Het domein red.local is toegankelijk en het netwerk is juist geconfigureerd
- De domeincontroller, ALFA2 is correct geïnstalleerd en beschikbaar.

- De server PAPA2 is aangemaakt en de documentatie is correct doorlopen.


# Postconditie

- Papa2 server is nu een volwaardige 'System Center Configuration Manager' server

- Het deployen van een Windows Client is mogelijk

# Testing

#### Log in op de PAPA2 server met de volgende gegevens (verkregen van de DC) :

      Account name: RED\Administrator

      Password: Project2018

## Naam server en domein

1. Klik op start en open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Klik binnen de server manager op local server.
3. Controleer volgende settings:
   - Computer name: PAPA2
   - Domain name: red.local

## Netwerksettings

1. Open de command line
2. Voer het commando 'ipconfig /all' uit
3. Controleer de netwerkconfiguratie, deze moet als volgt zijn:
- Ip-address: 172.18.0.7
- Subnetmask: 255.255.255.224
- Default gateway: 172.18.0.1
- Preferred dns: 172.18.0.34
- Alternate dns: 172.18.0.35

## Roles

1. Klik op start en open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Controleer of in de kolom aan de linkerkant de rollen IIS en WSUS staan.
## Een geslaagde installatie ziet er zo uit op de C:\ schijf

![Screenshot](Pictures/cdrive.png)

## Een geslaagde SCCM

![Screenshot](Pictures/sccm.png)

## Extra informatie over de user die we hebben gebruikt

![Screenshot](Pictures/user.png)

Nu de installatie gelukt is, gaan we SCCM verder configureren. We moeten de operating systems Windows 7 Enterprise en/of Windows 10 Enterprise images deployen naar de Windows Clients. Ook moeten we zorgen voor de updates naar de Clients en deze applicaties deployen op de clients:

- Office 2013 of 2016
- Adobe Acrobat Reader laatste versie
- Java Packages
- Adobe Flash componenten voor IE en Firefox

Deze .MSI's staan onder het mapje ../MSI's.
