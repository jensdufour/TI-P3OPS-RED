# Installatieprocedure ALFA 2

Auteur(s) installatieprocedure: Bert Provoost.

# Preconditie
 * Server bestaat, Windows Server 2016 is geïnstalleerd
 * server heeft 1 NAT adapter en 1 Netwerk Bridge adapter.

# Postconditie
 * DC Services zijn geïnstalleerd
 * DNS is juist ingesteld
 * Domeinconfiguratie voltooid:
   * 5 groepen zijn aangemaakt (en bijhorende OU)
   * Een aantal users zijn aangemaakt en toegekend aan groepen
   * De volgende policies worden toegepast
     * Control panel uitgeschakeld
     * Games link verwijderd
     * Administratie en Verkoop hebben geen toegang tot netwerkadapters

# Uitvoer handmatig

### Verander servernaam.
 * Ga in het server manager dashboard naar local server en klik op de Computer Name.  
 * Bij computer description geef je AD DC in en klik dan bij rename computer op change.
 * Verander de naam naar NS1 en klik OK.
 * Herstart de server.

### Stel het juiste IP adres in.
 * Ga naar het Network and Sharing center en geef voor Ethernet2 de volgende instellingen mee:  
 ![ipconfig](https://user-images.githubusercontent.com/17174277/47616491-bda23b00-dabd-11e8-8fd3-b39273bd70a6.png)

### Schakel de firewall uit.
 * Zoek in het startmenu naar windows firewall en ga naar de tab: turn windows firewall on or off.
 * Schakel de firewall uit voor private en public netwerken.
 * Klik ok.
### Installeer AD DC.
 * Ga weer naar het server manager dashboard en klik op add roles and features.
![dashboard](https://user-images.githubusercontent.com/17174277/47568918-9ec36d80-d932-11e8-911e-2907d6029ee0.png)
 * Klik op next.
 * Kies Role-based or feature-based installation en klik next.
 * Selecteer NS1 als server en klik next.
 * Kies de optie Active Directory Domain Services.
 ![adds optie](https://user-images.githubusercontent.com/17174277/47569075-024d9b00-d933-11e8-8aae-cc349b6b730d.png)
 * Klik op add features.
 * Klik op next tot je niet meer op next kan klikken.
 * Kies nu voor install.
 * De installatie kan even duren.
 * Als de installatie gedaan is klik NIET op close maar kies de optie: Promote this server to a domain controller.
 ![promote](https://user-images.githubusercontent.com/17174277/47569458-f6aea400-d933-11e8-94ba-60cb6675a22c.png)
 * Kies voor de optie Add a new forest en geef als Root domain name "red.local"
 * Op het volgende scherm moet je even wachten totdat je het password kan invullen. Wij kiezen hier voor "Project2018" en bevestig nogmaals.
 * Klik 1 keer op next.
 * Als je even wacht zal de NetBIOS name automatisch worden ingesteld op RED.
 * Klik 2 keer op next.
 * Je moet nu even wachten totdat de server alles geverifieerd heeft.
 * Klik op install. Dit zal zeker een paar minuten duren.
 * De server zal moeten herstarten nu. Het herstarten zal ook een paar minuten duren.
 * Je kan weer inloggen met het wachtwoord "Project2018".

### Maak Groepen en Users aan (niet letten op de group werkstations in de fotos).
 * Kies in het server manager dashboard bij Tools voor "Active Directory Users and Computers".
 ![users and computers](https://user-images.githubusercontent.com/17174277/47575932-8c9dfb00-d943-11e8-9bc7-b49496b6da91.png)
 * Rechtsklik op red.local en kies "New Organizational Unit".
 * Kies "RED" als naam.
 * Rechtsklik op RED en kies "New Organizational Unit" en maakt zo Administratie, Directie, ITAdministratie, Ontwikkeling & Verkoop aan(sub OU's).
 * Rechtsklik op de sub OU's en kies telkens "New Group".
 * Geef voor de groepen telkens de corresponderende namen. Maak zo telkens 1 group per sub OU: Administratie, Directie, ITAdministratie, Ontwikkeling & Verkoop.
 * Rechtsklik op de sub OU's en kies "New User" maak zo telkens 1 user per sub OU(Admministratie User, Directie User,...) geef als password "P@ssword" mee en vink "User must change password at next logon" af.

 ![create user object](https://user-images.githubusercontent.com/17174277/47575396-4c8a4880-d942-11e8-880e-303fa263991f.png)

 * Je zie nu alle OU's met telkens 1 group en 1 user in.
![ou met user](https://user-images.githubusercontent.com/17174277/47576356-852b2180-d944-11e8-8365-ce932030e77e.png)
 * Rechtsklik nu op elke user die je hebt aangemaakt en kies "add to group...".
 * Vul nu telkens de group van deze user in en klik op "Check Names". Als de naam word onderstreept is de group geldig.

### Maak policies aan en link ze aan groepen.
 * Zoek in het startmenu onder de map "Windows Adminstrative Tools" naar "Group Policy Management".
![gpo](https://user-images.githubusercontent.com/17174277/47576901-e3a4cf80-d945-11e8-930a-5522eb5dfbdb.png)
 * klap "Forest: red.local" uit, klap "red.local" uit & klap "Group Policy Objects" uit.
 ![gpo2](https://user-images.githubusercontent.com/17174277/47577068-45fdd000-d946-11e8-9153-3f4aadf3cfd3.png)
 * Rechtsklik op "Group Policy Object", "new" en kies de naam "RemoveGamesLink" en klik OK.
 * Rechtsklik op de "RemoveGamesLink" en kies edit.
 * Open nu onder "User Configuration" de "policies" en klap "Administrative Templates:..." uit.
 * Klik op "Start Menu and Taskbar" en rechtsklik aan de rechterkant op "Remove Games Link form Start Menu" en kies edit.
 ![removegameslink](https://user-images.githubusercontent.com/17174277/47577470-46e33180-d947-11e8-96c8-c21eaf41db28.png)
 * Vink "Enabled" aan en klik op OK.
 * Sluit het venster "Groep Policy Management Editor".
 * In het venster "Group Policy Management" klik weer rechts op "Group Policy Object" kies "new" en maak de GPO "DisableControlPanel" aan.
 * Rechtsklik op "DisableControlPanel" en kies weer voor edit.
 * Open weer onder "User Configuration" de "policies" en klap "Administrative Templates:..." uit en klik op "control panel".
 * Rechtsklik op "Prohibit access to Control Panel and PC settings" en kies voor edit.
 ![disablecontrolpanel](https://user-images.githubusercontent.com/17174277/47616076-12db4e00-dab8-11e8-8898-fc2786b81b8b.png)
 * Vink enabled aan en klik op OK.
 * Sluit het venster "Groep Policy Management Editor".
 * In het venster "Group Policy Management" klik weer rechts op "Group Policy Object" kies "new" en maak de GPO "DisableNetwerkAdapter" aan.
 * Rechtsklik op "DisableNetwerkAdapter" en kies weer voor edit.
 * Open weer onder "User Configuration" de "policies", klap "Administrative Templates:..." uit en klap "Network" uit en klik op "Network Connections".
 * Rechtsklik op "Prohibit access to properties of a LAN connection" en kies voor edit.
 ![prohibitnetworkaccess](https://user-images.githubusercontent.com/17174277/47616056-d9a2de00-dab7-11e8-8497-00c9de947c7c.png)
 * Vink ebabled aan en klik op OK.
 * Sluit het venster "Groep Policy Management Editor".
 * In het venster "Group Policy Management" rechtsklik op red.local en kies refresh.
 * Klap "RED" open, rechtsklik op "Administratie" en kies voor "Link and Existing GPO..."
 ![linkgpo](https://user-images.githubusercontent.com/17174277/47616355-f8a36f00-dabb-11e8-9bb1-452517921162.png)
 * Selecteer de GPO die je wilt linken.
   * DisableControlPanel: Alle groepen.
   * RemoveGamesLink: Alle groepen.
   * DisableNetworkAdapter: voor Administratie en Verkoop.
 * Doe dit voor alle groepen.
 * De basisconfiguratie is nu uitgevoerd. We moeten nog instellingen doen voor dns.
###Instellingen DNS: Alias
 * Hier voegen we de nodige alliasen toe, en zorgen we dat dns requests naar green.local geresolved kunnen worden
 * Open DNS Management
 * Dubbelklik op de dns server
 * Dubbelklik op 'forward lookup zones'
 * Rechtsklik op de domeinnaam
 * Selecteer 'New Alias (CNAME)'
 * Geef de alias van de server in (bijvoorbeeld www)
 * Geef de FQDN van de server in (bijvoorbeeld delta2.red.local)
 * Druk op OK
 * Herhaal dit voor alle nodige aliasses
   * Om red.local door te verwijzen naar de webserver, kies voor de optie 'New Host (A or AAAA)'
   * Laat het bovenste vakje leeg, vul onderaan het ip adres van de webserver in
   * Druk op ok
###Instellingen DNS: green.local
 * Nog altijd in DNS Management, rechtklik op de forward lookup zones
 * Selecteer 'Create new zone'
 * Selecteer 'Secondary Zone' als zonetype
 * Als zonename geef je in 'green.local'
 * Als master dns server geef je het ip mee van de dns server van green.local
 * Druk verder op next. De zone wordt aangemaakt, en de records worden overgenomen van green.local
 
# Uitvoer met scripts.

 * Voer het script ALFA2_NAME.ps1 uit.  
 * Voer het script ALFA2_ADDC.ps1 uit.
 * Voer het script ALFA2_GREEN.ps1 uit.
 * Voer het script ALFA2_OU.ps1 uit.
 * Voer het script ALFA2_POLICIES.ps1 uit.
   * Hier zal je zelf nog 3 keer het pad moeten aanpassen van waar je de backup wilt halen!
