# Documentatie : November2

## Algemene info

Een member server in het domein red.local. Deze server is een Microsoft MS SQL-Server voor mike2 (Sharepoint) en voor delta2 (publieke webserver).

Naam server: November2 <br>
Domeinnaam: red.local <br>
IP-adres: 172.18.0.5 <br>
Aangemaakte user: Administrator <br>
Wachtwoord: Project2018 <br>
Domein user: Administrator@red.local<br>
Domein wachtwoord: Project2018 <br>

### Installatie procedure

1. Installeer Windows Server 2016
2. Verander de hostnaam, ip-instellingen en firewallinstellingen.
November2 heeft volgende instellingen:
   - Hostnaam: November 2
   - Firewall: Off
   - Ip-address: 172.18.0.5
   - Subnet mask: 255.255.255.224 
   - Default gateway: 172.18.0.1
   - Preferred DNS: 172.18.0.34
   - Alternate DNS: 172.18.0.35
 3. Installeer SSMS
 4. Voeg de server toe aan het domein red.local (Verander loginggegevens naar RED\Administrator, passwoord Project2018)
 5. Restart de server.
 6. Installeer Microsoft Sql Server 2017
 7. Restart de server.
 
### Basis configuratie
- Configureer de basis configuratie via de gui.

#### AUTOMATISATIE
- De basis configuratie van de server wordt geconfigureerd door scripts 1_hostname.ps1 en 2_settings.ps1

### Installeer Microsoft SQL Server Management Studio
- Voer de SMSS-ENU-setup.exe uit en installeer.

#### AUTOMATISATIE
- Voer het script SSMS.ps1 uit. Variablen kunnen verandert worden op basis van de file locaties.

### Installatie Microsoft SQL Server 2017
BELANGRIJK: November2 moet in het domein zitten voordat de sql geïnstalleerd wordt. Anders als er alleen NOVEMBER2\Administrator toegevoegd is als users bij de setup moet men eerst een login maken in de SQL SERVER, met NOVEMBER2\Administrator ingelogd op de virtual machine, voor RED\Administrator. Anders kan er via het netwerk niet met RED\Administrator ingelogd worden op de SQL SERVER.

De sqlserver.iso / SMSS-setup is te vinden in het november2.iso file op de datastore1.

Zet de sqlserver.iso lokaal op de pc (Op het bureaublad bv) en mount deze. Hierna druk op setup en volg de pdf.

Opmerkingen bij de installatie volgens de pdf van olod "Windows server":
- Feature Selection: Alleen database/analysis services zijn nodig
- Database Engine Configuration: Verwissel naar mixed mode -> Het passwoord is "Project2018"

#### AUTOMATISATIE
- Installeer SQL Server met de ConfigurationFile.ini, dit bevat alles van een werkende SQL Server op het red.local domein. Open de setup.exe, ga naar de tab "Advanced" en kies "Install based on configuration file"

### SQL SETUP
- Open "SQL Server Configuration Manager" in het Start Menu.
- Zorg er zeker voor dat bij SQL Server Services al deze Services runnen!!!
- Zorg er voor dat TCP/IP en mogelijks andere protocols Enabled zijn!!! Bij SQL Native... Configuration, SQL Server.... Check dit zeker!

![alt text](images/november21.png)

- Klik bij SQL Server Services rechts op “SQL Server (MSSQLSERVER)”.
- Selecteer “Properties”.
- Selecteer de “FILESTREAM” tab en zorg ervoor dat alle opties aangevinkt staan.
- Bij het tablad "Services" duid je bij Start Mode "Automatic" aan.
- Klik op “OK”en sluit “SQL Server Configuration Manager”.

![alt text](images/november27.png)
![alt text](images/november28.png)



- Open "Microsoft SQL Server Management Studio" in het Start Menu.
- Verbind door Windows Authentication met je SQL Server.
- Bovenaan rechtsklik op je Server -> Properties.
- In het nieuwe venster klik op "Security".
- Zorg er zeker voor dat "SQL Server and Windows Authentication Mode" is gekozen!!!

![alt text](images/november22.png)

- Klik op "Connection" en selecteer "Allow remote connections on this server".

![alt text](images/november26.png)

- Sla deze instellingen op.

### Aanmaken DB en User voor Delta2
- In "Microsoft SQL Server Management Studio", rechtsklik "Databases" en klik op "New Database".
- Vul bij de Database Name "Website" in klik op Ok. De Database wordt aangemaakt.

![alt text](images/november23.png)


- Klik op "Security", rechtsklik op "Logins" en klik op "New Login".
- Vul bij "Login Name" "Website" in en selecteer "SQL Server Authentication". Kies als Password "Admin2018".
- Deselecteer "Enforce Password Policy" zodat SQL Server niet vraagt om nieuwe wachtwoord aan te maken bij login.

![alt text](images/november24.png)


- Klik links op "User Mapping" en selecteer het vakje naast de database "Website". Klik onderaan ook DB_OWNER aan!!!.

![alt text](images/november25.png)

- Klik op "OK" en de Gebruiker wordt aangemaakt.
- Deze gebruiker kan nu gebruikt worden door de Delta2 server!

### Aanmaken DB en User voor Mike2
- In "Microsoft SQL Server Management Studio", Klik op "Security".
- Rechtsklik op de domein user ex. RED\Administrator.
- Deselecteer "Enforce Password Policy" zodat SQL Server niet vraagt om nieuwe wachtwoord aan te maken bij login.
- Klik links op "User Mapping". Klik onderaan op DB_OWNER, DBCreator!!
- Klik op "OK" en de Gebruiker wordt gewijzigd.
- Deze gebruiker kan nu gebruikt worden door de Mike2 server!
