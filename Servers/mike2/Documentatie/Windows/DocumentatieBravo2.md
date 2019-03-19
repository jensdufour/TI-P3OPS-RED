# Bravo2: documentatie

## Algemene info

Een tweede Domain controller die eveneens dienst doet als tweede DNS-server voor het domein.De buitenwereld kent deze server als "ns2".

Naam server: ns2 <br>
Domeinnaam: red.local <br>
IP-adres: 172.18.0.35/27<br>
Aangemaakte user: Administrator <br>
Wachtwoord: Project2018 <br>

### Toelichting script
- Stelt juiste ip adres in (172.18.0.35/27), default gateway (172.18.0.33) <br>
- Computernaam veranderen naar ns2 <br>
- Firewall uitschakelen
- Adds installeren <br>
- Toevoegen aan domein red.local (requires alfa2) <br>

## Installatie handmatig
1. Start met een clean install van Windows Server 2016, start deze server op
2. Ga in het server manager dashboard naar local server en klik op de Computer Name.
3. Geef als description 'back up domain controller and dns server for domain red.local" in, en verander de computernaam naar ns2. De server moet hiervoor opnieuw gestart worden.
4. Ga naar het Network and Sharing center en geef voor Ethernet2 de volgende instellingen mee: <br>
  Ip-address: 172.18.0.35 
  Default gateway: 172.18.0.33  <br>
  Preferred dns: 172.18.0.34 <br>
  Alternate dns: 172.18.0.35 <br>
5. Ga terug naar het server manager dashboard en klik op add roles and features. 
6. Klik op next. Kies Role-based or feature-based installation en klik next. Selecteer NS2 als server en klik next.
7. Kies de optie Active Directory Domain Services. Klik op add features en klik daarna op next tot het installatiescherm.
8. Voer de installatie uit.
9. Als de installatie afgelopen is, kies je de optie 'Promote this server to domain controller'
10. Kies voor de optie "Add a domain controller to an existing domain". Geef bij Domain "red.local" in. 
11. Verander de Credentials naar RED\Administrator met wachtwoord Project2018. Druk op Next.
12. Controleer of GC en DNS server aangevinkt staan. Geef als DSRM passwoord 'Project2018 in' en druk op Next tot het scherm 'Additional options.
13. Kies bij Additional Options voor replicate from alfa2.
14. Klik verder op Next en voer de installatie uit. Als de installatie voltooid is, zal de server opnieuw starten.
<br>

## Installatie en automatisatie 
1. Start met een clean install van Windows 2016
2. Voor het powershellscript bravo2Basic.ps <br>
3. De server zal herstarten. Log opnieuw in en voer bravo2Join.ps uit.
4. Na uitvoering van het script werd Bravo2 geconfigureerd.
