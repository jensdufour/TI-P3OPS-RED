# Testplan bravo2

Auteur(s) testplan: Raman Michiel

# Preconditie
- Bravo2 is geconfigureerd: domain controller in domein red.local, slave dns server <br>
- Alle servers zijn lid van het domein red.local
- Ingelogd op bravo2 met volgende inloggegevens: <br>
    *Account name: RED\Administrator* <br>
    *Passwoord: Project2018* <br>
  <br> 
# Testing

### Naam server en domein
1. Klik op start en open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Klik binnen de server manager op local server. 
3. Controleer volgende settings:
   - Computer name: ns2
   - Domain name: red.local
4. Alternatief stap 2: open cmd, voer de commando's "Hostname" en "wmic computersystem get domain"

### Netwerksettings
1. Klik op start en open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Klik op local server en klik daar op de 'host only' adapter
3. Klik 'Internet Protocol version 4' aan, en druk op properties.
4. Controleer de netwerkconfiguratie, deze moet als volgt zijn: <br>
  - Ip-address: 172.18.0.35 <br>
  - Subnetmask: 255.255.255.224 <br>
  - Default gateway: 172.18.0.33 <br>
  - Preferred dns: 172.18.0.34 <br>
  - Alternate dns: 172.18.0.35  <br>
  
Alternatieve testmethode:
1. Open de command line 
2. Voer het commando 'ipconfig /all' uit
3. Controleer de netwerkconfiguratie, deze moet als volgt zijn:
  - Ip-address: 172.18.0.35 <br>
  - Subnetmask: 255.255.255.224 <br>
  - Default gateway: 172.18.0.33 <br>
  - Preferred dns: 172.18.0.34 <br>
  - Alternate dns: 172.18.0.35 <br>

### Roles
1. Klik op start en open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Controleer of in de kolom aan de linkerkant de rollen AD DS en DNS staan. 

## Testen duplicatie van alfa2: OU's
1. Open de server manager (indien dit niet automatisch gebeurt is bij het opstarten)
2. Ga rechts bovenaan in het scherm via 'Tools' naar 'Active Directory Users and Computers'
3. Open 'red.local'
4. De verschillende OU's aangemaakt bij de configuratie van alfa2 moeten zichtbaar zijn op bravo2: <br>
   - IT Administratie <br>
   - Verkoop <br>
   - Administratie <br>
   - Verkoop <br>
   - Ontwikkeling <br>

## Testen duplicatie van alfa2: computers en dc's
1. Open de server manager (indien dit niet automatisch gebeurt is bij het opstarten
2. Ga via 'Tools' naar 'Active Directory Users and Computers'
3. Open 'red.local'
4. Bij Domain Controllers moeten er 2 entries staan: <br>
   - NS1 <br>
   - NS2 <br>
5. Bij Computers moeten volgende servers zichtbaar zijn (testen nadat alle andere servers het domein gejoined zijn): <br>
   - Charlie2 <br>
   - Delta2 <br>
   - Kilo2 <br>
   - Lima2 <br>
   - Mike2 <br>
   - November2 <br>
   - Oscar2 <br>
   - Papa2 <br>




   
 
