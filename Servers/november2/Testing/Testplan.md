# Testplan november2

Auteur(s) testplan: Poelaert Jeroen, Aron Marckx

# Preconditie
- alfa2 en/of bravo2 is/zijn correct geconfigureerd en operationeel.<br>
- Ingelogd op november2 met volgende inloggegevens: <br>
    *Account name: RED\Administrator* <br>
    *Password: Project2018* <br>
  <br> 
# Testing

## Naam server en domein
1. Klik op start en open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Klik binnen de server manager op local server. 
3. Controleer volgende settings:
   - Computer name: November2
   - Domain name: red.local
4. Alternatief stap 2: open cmd, voer de commando's "Hostname" en "wmic computersystem get domain"

## Netwerksettings
1. Klik op start en open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Klik op local server en klik daar op de 'host only' adapter
3. Klik 'Internet Protocol version 4' aan, en druk op properties.
4. Controleer de netwerkconfiguratie, deze moet als volgt zijn: <br>
  - Ip-address: 172.18.0.5 <br>
  - Subnet mask: 255.255.255.224 <br>
  - Default gateway: 172.18.0.1 <br>
  - Preferred dns: 172.18.0.34 <br>
  - Alternate dns: 172.18.0.35  <br>

Alternatieve testmethode:
1. Open de command line 
2. Voer het commando 'ipconfig/all' uit
3. Controleer de netwerkconfiguratie, deze moet als volgt zijn:
  - Ip-address: 172.18.0.5 <br>
  - Subnet mask: 255.255.255.224 <br>
  - Default gateway: 172.18.0.1 <br>
  - Preferred dns: 172.18.0.34 <br>
  - Alternate dns: 172.18.0.35 <br>
  
## Nakijken correcte SQL Server installatie

1. Kijk de versie en installatiefolder na in "Program Files".
2. Indien de folder "Microsoft SQL Server" aanwezig is, is het geinstalleerd.
3. Open het cmd venster. (Of via Start > Programs > Accessories > Command Prompt).
4. Typ het commando : "SQLCMD -S November2"
5. Typ het commando : "select @@version"
6. Typ het commando : "go"
7. Vergelijk de geretourneerde versie met de verwachte versie. 

## Nakijken correcte SQL Server installatie

1. Open het cmd venster. (Of via Start > Programs > Accessories > Command Prompt)
2. Typ het commando : "SQLCMD -S November2\MSSQLSERVER
3. Indien de 
4. Typ het commando : "select @@version"
5. Bij het 2 > prompt, typ "go"
6. Indien de SQL versie overeenkomt is het correct geinstalleerd.

## (Optioneel) Nakijken SQL Server instance name

1. Open het cmd venster. (Of via Start > Programs > Accessories > Command Prompt)
2. Typ het commando : "services.msc"
3. Ga door de lijst, zoek naar de entry die begint met "SQL".
4. Ga na of de entry overkomt met de gebruikte instance name.

## Testen Firewall
1. Start > Run > wf.msc
2. Windows Firewall -> advanced settings -> inbound rules
3. Controleer of de rule **SQL port 1433** staat.




   
 
