# ALFA2: Documentatie

## Algemene info

Domeincontroller met DNS. Dit is de Master DNS server voor het domein red.local. Externe DNS-requests worden doorgegeven aan de daarvoor meest geschikte server.
Naam server: ns1  
Domeinnaam: red.local  
IP-adres: 172.18.0.34/27  
Aangemaakte user: Administrator  
Wachtwoord: Project2018  

### Toelichting script

#### ALFA2_NAME
 * Hernoemt de server naar "ns1"

#### ALFA2_ADDC
 * Stelt het ipadres in op 172.18.0.34/27, en de default gateway op 172.18.0.33
 * Schakelt firewall uit
 * Installeert AD services
 * Maakt forest aan 'red.local', en maakt de server Domeincontroller van dit domein

#### ALFA2_OU
 * Maakt OU aan
 * Maakt groepen aan
 * Maakt een voorbeelduser aan voor elke groep

#### ALFA2_POLICIES
 * Maakt Group Policies aan
 * Linkt de policies aan de juiste groepen
 * Laad de Group Policy in vanaf backups

###  ALFA2_GREEN
  * maakt een reversed lookup zone aan
  * maakt een Forward lookup zone aan voor green.local
  * stelt aliassen in.

## Installatie en automatisatie (WIP)
1. Start met een schone installatie van Windows Server 2016
2. Voer het powershell-script ALFA2_NAME uit
3. De Windows Server herstart automatisch
4. Voer het powershell-script ALFA2_ADDC uit
5. De Windows Server herstart automatisch
6. Voer het powershell-script ALFA2_GREEN uit
7. Voer het powershell-script ALFA2_OU uit
8. Voer het powershell-script ALFA2_POLICIES uit
9. Na het uitvoeren van deze stappen is ALFA2 geconfigureerd

## Instellen DNS voor Delta2
1. Open de DNS manager op Alfa2.
2. Bij Forward lookup zones, rechtsklikken en een A record toevoegen. De name laat je leeg en bij het ip adres vul je 172.18.0.37 in. Het ip van Delta2. Dit sla je op.
3. Bij Forward lookup zones, rechtsklikken en een A record toevoegen. De name vul je "www" in en bij het ip adres vul je 172.18.0.37 in. Het ip van Delta2. Dit sla je op.
4. Normaal moet je nu naar red.local en www.red.local kunnen surven en de webserver bereiken.
