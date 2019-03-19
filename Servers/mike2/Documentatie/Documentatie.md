# Preconditie

 * Server bestaat, Windows Server 2016 is geïnstalleerd

# Postconditie

 * Correcte IP Instellingen
 * Verbonden met red.local
 * Sharepoint is geïnstalleerd op de server.
 * Sharepoint configuratie is correct, er wordt verwezen naar November2 voor de database.
 * documentatie Windows als inhoud

# Uitvoer

### Stel servernaam in

 * Ga naar het tabblad 'local server' in server manager
 * Klik op de naam van de computer
 * Klik op change
 * Verander de naam naar 'Mike2' en druk op ok

 ![Verander de naam](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/name.png)

### Stel IP adres in

 * Open het network and sharing center, en ga naar de eigenschappen van Ethernet
 * Klik op Internet Protocol version 4
 * Vul de instellingen op de volgende manier in: 
 ![Stel netwerk instellingen in](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/ip.png)

### Schakel firewall uit

 * Ga naar de firewall instellingen
 * Schakel alle firewalls uit
 ![Firewall uitschakelen](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/ip.png)

### Join het domein

 * Ga naar hetzelfde venster waar je de naam van de computer ingevuld hebt
 * Stel red.local in als domein
 * Geef de credentials van de domeinadministrator in (Alfa2)

## Installatie Sharepoint

### Installeer de nodige rollen

 * Dit lukt het best door het script mike2_roles.ps1 uit te voeren

### Installeer de prerequisites

 * Mount het iso bestand van Sharepoint.
 * Plaats de folder prerequisites op de server.
 * Voer het bestand msodbsql.msi uit. Open een cmd en ga naar de directory van msodbsql, voer vervolgens volgend commando uit `msodbcsql.msi IACCEPTMSODBCSQLLICENSETERMS=YES /quiet /norestart`. (Dit lost een probleem op met een dode link)
 * Vervolgens voer je PrerequisiteInstaller.exe uit, dit bestand staat in de gemounte .iso en word gebruikt voor een online installatie. Je kan ook de Offline installatie doen door het script `3_Mike2_pre-requisites`. Zorg hier dat al de prerequisites onder C:\prerequisites staan. 
 * Bij het uitvoeren van bovenstaande zal de pc terug moeten opstarten, dit geeft een probleem aangezien na het herstarten van de computer de .iso niet meer gemount is. je kan:
   1. De eerste en meest vertrouwelijke oplossing. Je mount de .iso file terug en je opent een CMD met administrator rights. Hierachter voer je volgend commando uit voor de installatie van de pre-requisites af te ronden. PS F:> .\prerequisiteinstaller.exe /continue
   2. De tweede Manier is niet echt de beste, maar hij werkt. net na de opstart ga je direct naar de locatie van je .iso file en je dubbelklit om hem te mounten. Als dit is gelukt vooraleer de CMD opent, verloopt alles normaal.

### SQL Server
 * Voor het testen kan men een lokale SQL databank gebruiken. 
 * Gebruik hiervoor `en_sql_server_2016_developer_x64_dvd_8777069.iso`
 * voor de installatie kijk je best of de volgende test slaagt bij het runnen van de setup in de .iso: "System Configuration Checker". Een van de meest voorkomend fout is: "Oracle JRE 7 Update 51 (64-bit) or higher is required" hier ga je volgend bestand uitvoeren(jre-8u191-windows-x64.exe).
 * Doorloop alles met Next en OK
 * Een bij de Feature select klik je op "Select All", ga vervolgens door.
 * Als je op Server Configuration komt, wet je SQL Server Agent op Automatic, de rest blijft onveranderd.
 * Telkens als je een user moet meegeven, geef de Domain admin mee en de Local admin.
 * Bij Reporting Services Configuration kies je 'Install and Configure'
 * Blijf doorgaan tot einde installatie.
### Installeer Sharepoint

 * Voer het bestand setup.exe uit (op de gemounte iso file). En voeg volgend product key in: `DMFTQ-NF7WV-JVKFX-Q8TFK-YDW2F`
 * of voer het script `4_Mike2_Installation.ps1`


## Configureer Sharepoint

 * Begin van de configuratie

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/1.png)

 * Negeer volgende medling en druk op `Yes`

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/2.png)

 * Kies voor Create a new server farm

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/3.png)

 * . : verwijst naar lokale Server
 * SharePoint_Config is default, verander dit niet
 * Geef de domain Admin Username en passwoord

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/4.png)

 * Zorg dat de passphrase lang genoeg is

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/5.png)

 * Kies voor Single-ServerFarm

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/6.png)

 * Specifieer het poortnummer en kies 9999. Geen random poortnummer nemen.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/7.png)

 * Dit is een overzicht van alle ingevulde gegevens, druk op `Next`

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/8.png)

 * Wachten maar!

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/9.png)

 * Dit is een Overzicht van de gekozen configuratie, klik op `Finish`

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/10.png)

 * U zal doorgeleid worden naar de Configuration web applicatie. Geef de Juist gebruikersnaam en wachtwoord.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/11.png)

 * Kies voor No.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/12.png)

 * Dit is de pagina die u krijgt, navigeer naar Manage web applications.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/13.png)

 * Op deze pagina kies je voor `New`, dit is links boven te vinden.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/14.png)

 * Geef volgende gegevens in: Verander naam naar "SharePoint - 8080", Port : 8080. Kijk ook eens na of het pad mee aangepast is. Tenslot kies je voor Allow Anonymous: 'Yes'.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/15.png)

 * Geen aanpassing nodig, klik op OK.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/16.png)

 * En wachten maar. De Indicatie dat aangeeft dat de computer is kan vastzitten. Gelieve te wachten tot volgende schermen.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/17.png)

 * Wachten

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/18.png)

 * Klik op OK, de webapplicatie hoort nu aangemaakt te zijn.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/19.png)

 * Geef de Sharepoint een titel, bv. Documenten, en een bijhoorende beschrijving.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/21.png)

 * Geef opnieuw gebruikers in, Als eerste de Domain Admin en als tweede de Local Admin.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/20.png)

 * Wachten

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/22.png)

 * Bericht dat site collection gemaakt is. Klik op openen in nieuw tabblad ( In mijn voorbeeld is dit http://SharePoint2:8080).

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/23.png)

 * Geef juiste gebruikersnaam en wachtwoord

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/24.png)

 * Wachten

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/25.png)

 * Hier is uw SharePoint 2016

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/26.png)



**Grant anonymous access**

Klik op webapplicatie -> Authentication Providers -> Default -> enable anonymous access *aanvinken* 
​                                       -> Anonymous Policy -> all zones / None - No policy

Op de site zelf -> Site permissions -> Anonymous Access -> Entire Web Site (new anonymous user will be added to the site permission page)



**Toevoegen inhoud**

Ga naar de website. 

Hier kan je de bestanden uploaden. Druk op Upload en kies de gewilde bestanden.

Deze zullen vervolgens geupload worden naar de database.

![](https://github.com/HoGentTIN/p3ops-red/blob/master/Servers/mike2/Documentatie/Foto/Upload.png)

## Bronnen

https://www.capterra.com/content-management-software/

https://techcommunity.microsoft.com/t5/Enterprise-Mobility-Security/Windows-PowerShell-Examples-for-Content-Management/ba-p/248043

https://github.com/pkjaer/tridion-powershell-modules

https://medium.com/niftit-sharepoint-blog/step-by-step-guide-to-setting-up-sharepoint-server-2016-32c22555e545

https://gallery.technet.microsoft.com/office/SharePoint-2016-Prerequisit-17912ad2

https://fabdulwahab.com/2018/01/11/install-sharepoint-2016-prerequisites-offline-manually/

http://nikcharlebois.com/installing-the-sharepoint-2016-prerequisites-offline-using-powershell/

https://itgroove.net/mmman/2016/02/11/how-to-restart-the-sharepoint-prerequisite-installer-after-reboot-when-using-a-mounted-iso/

<https://github.com/Christwe/SharePointDSCSimpleFarm>

<https://social.technet.microsoft.com/wiki/contents/articles/20399.sharepoint-2013-the-local-farm-is-not-accessible-cmdlets-with-featuredependencyid-are-not-registered.aspx>

<http://www.sharepointdiary.com/2016/12/create-sharepoint-2016-farm-using-powershell.html>

<https://docs.microsoft.com/en-us/sharepoint/administration/document-farm-configuration-settings>





SQL SERVER BUTTTTTT: https://www.c-sharpcorner.com/article/resolving-cannot-connect-to-database-master-at-sql-server-error-during-sharepo/



