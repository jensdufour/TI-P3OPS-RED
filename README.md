# p3ops-red

# Project 3: Systeembeheer - Team Red

Hier is onze langverwachte groepsrepository. Hierin is er een onderverdeling van verschillende servers zodat je in die mapjes uw documentatie en scripts kunt steken.

![overzicht](https://github.com/HoGentTIN/p3ops-red/blob/master/Pictures/Overzicht%20van%20het%20te%20realiseren%20netwerk.PNG)

# Opdrachtomschrijving

In deze opdracht is het de bedoeling om in één team twee complete netwerkdomeinen op te zetten, onderling doorverbonden, incl. alle typische diensten: DNS, web, e-mail, enz. Het is aan het team om te beslissen wie welke taken op zich zal nemen om die uit te werken, te testen en op te leveren.
Elk teamlid draagt de eindverantwoordelijkheid voor minstens één deeltaak/component van het netwerk en beschrijft dit in haar/zijn logboek.
Lees de opgave grondig en doe zo goed mogelijk wat gevraagd wordt. Let er op dat bij verschillende taken addertjes onder het gras zitten, of dat ze bewust vaag geformuleerd zijn. Waar er geen expliciete keuze is opgelegd, kan het team zelf beslissen, in samenspraak met de begeleiders. De opgave kan in de loop van het semester, naargelang de omstandigheden, nog bijgestuurd worden.
De begeleiders kunnen bijkomende requirements opleggen of desgevallend de scope beperken.
Het team kan zelf ook initiatief nemen om -telkens in samenspraak met de begeleiders- extra’s te implementeren.
Jullie zullen merken dat jullie bij de meeste opdrachten van elkaar afhangen. Spreek dus goed af en maak duidelijke afspraken die voor iedereen toegankelijk zijn via de technische documentatie van het project. Streef er naar om diegenen die van jou afhangen zo goed mogelijk te helpen en hun werk zo vlot mogelijk te maken. Dat kan bestaan uit het ter beschikking stellen van een testomgeving voor de componenten onder jouw verantwoordelijkheid, hulp bij het gebruik ervan, of het vereenvoudigen van het gebruik door automatisering.

# Windows Servers VLAN 300 en VLAN 500
## alfa2
Domeincontroller met DNS. Dit is de Master DNS server voor het domein red.local. Externe DNS-requests worden doorgegeven aan de daarvoor meest geschikte server.
De buitenwereld kent deze server als “ns1”.

Client-pc’s hebben geen eigen gebruikers, authenticatie gebeurt telkens via de domeincontroller.
Maak hiervoor onderstaande afdelingen (groepen) aan.
* IT Administratie
* Verkoop
* Administratie
* Ontwikkeling
* Directie

Maak een duidelijk verschil tussen gebruikers, computers en groepen. Voeg enkele gebruikers en minstens 5 werkstations toe (één in ITAdministratie, één in Ontwikkeling, één in Verkoop, één in Administratie en één in Directie).
Werk met zwervende profielen (roaming profiles).

Werk volgende beleidsregels uit op gebruikersniveau:
* Verbied iedereen uit afdelingen de toegang tot het control panel
* Verwijder het games link menu uit het start menu voor alle afdelingen
* Verbied iedereen uit de afdelingen Administratie en Verkoop de toegang tot de eigenschappen van de netwerkadapters.

Zorg voor de juiste toegangsgroepen voor de fileserver (Modify/Read/Full) en voeg de juiste personen en/of groepen toe. Meer info vind je onder lima2, de file-server. Maak gebruik van AGDLP (Account, Global, Domain Local, Permission) voor het uitwerken van de groepsstructuur.
## bravo2
Een tweede Domain controller die eveneens dienst doet als tweede DNS-server voor het domein.
De buitenwereld kent deze server als “ns2”.
## charlie2
Een mailserver (Exchange Server) met SMTP en IMAP. Gebruik steeds de meest recente versie.
Het moet mogelijk zijn mails te versturen en te ontvangen tussen de twee domeinen. Gebruikers in de directory server (AD) hebben ook een mailbox.
## delta2
Een publiek toegankelijke webserver met HTTP/HTTPS en voorzieningen voor dynamische webapplicaties (ASP.NET) en een demo-applicatie. Maak gebruik van een database. Het database-deel van de webapplicatie wordt uitbesteed aan november2. Je kan naar deze webserver surfen met het “www” voorvoegsel (vb. https://www.red.be/) vanop elke host in alle domeinen.
![tabel](https://github.com/HoGentTIN/p3ops-red/blob/master/Pictures/Tabel%203.1%20en%203.2.PNG)
## kilo2
Een interne member-server in het domein red.local die dienst doet als DHCP-server voor de interne clients.
## lima2
Een interne file-server. Zorg voor schijven voor de verschillende afdelingen, zoals aangegeven in tabel 3.1.
Pas toegangsrechten toe zoals aangeven in tabel 3.2.
OPGELET! De directories HomeDirs en ProfileDirs zijn toegankelijk voor iedereen. In de HomeDirs folder zitten alle home directories van alle domeingebruikers. Uiteraard kan elke gebruiker enkel in zijn eigen home directory lezen en schrijven. Alle andere gebruikers krijgen
geen toegang. Er wordt net hetzelfde gedaan met de profile directories in de ProfileDirs folder.
Stel volgende quota in:
* VerkoopData, DirData en AdminData maximum 100MB per gebruiker!
* OntwikkelingData en ITData maximum 200Mb per gebruiker!
* Stel in dat er voor AdminData dagelijks een schaduwkopie wordt gemaakt van de data.
Maak een map ShareVerkoop aan die gedeeld wordt met Verkoop en Ontwikkeling met toegangsrechten zoals in Tabel 3.2 aangegeven.
3.5 Windows Servers VLAN 300 en VLAN 500 25
## mike2
Een member server in het domein red.local. Deze server doet dienst als Intranet/CMS server (Sharepoint) die enkel toegankelijk is voor interne systemen uit het domein red.local.
Het database gedeelte van deze Sharepoint server staat eveneens op de database server november2.
Als inhoud voor deze CMS server voorzie je alle Windows documentatie van dit project.
## november2
Een member server in het domein red.local. Deze server is een Microsoft MS SQL-Server voor mike2 (Sharepoint) en voor delta2 (publieke webserver).
## oscar2
Een member server in het domein red.local. Deze server is een Real-Time Monitoring server die alle Windows Servers opvolgt. Deze Server maakt gebruik van de monitoring applicatie PRTG.
Volgende parameters worden minimaal opgevolgd :
* CPU gebruik.
* Geheugen gebruik.
* Toestand van de harde schij(f)(ven).
* Toestand van elke specifieke service die op een Windows server staat de draaien. (services zoals MS-SQL, Sharepoint, IIS, mail, . . . )
## papa2
Een member server in het domein red.local. Deze server is een Microsoft System Center Server.
Gebruik steeds de meest recente versie.
Deze server is verantwoordelijk voor het deployen van Windows 7 Enterprise en/of Windows 10 Enterprise images naar de Windows clients in VLAN 200.
Daarnaast zorgt deze server voor alle Windows en Office updates voor zowel de clients als de servers.
Deze Server moet ook in staat zijn om een aantal basis applicaties te deployen op de client PC’s. Volgende apllicaties moeten zeker kunnen uitgerold worden:
* Office 2013 of Office 2016
* Adobe Acrobat Reader laatste versie.
* Java Packages laatste versie.
* Adobe Flash componenten voor IE en Firefox.

# 3.6 Werkstations VLAN 20 en VLAN 200
Configureer op zijn minst 5 client pc’s waar een gebruiker kan op inloggen, e-mail kan lezen, en van waar de publieke en private services van het eigen en publieke services van andere domeinen kunnen getest worden.
Elk van deze PC’s is lid van één van gespecifieerde afdelingen in de directorystructuur (AD voor Windows en OpenLDAP voor Linux).
Zorg ervoor dat elke afdeling minimaal met 1 PC voorzien is.
# 3.7 Firewalls
* zulu1 bevindt zich tussen VLANs 60 en 70.
* zulu2 bevindt zich tussen VLANs 600 en 700.
* OS: De meest recente stabiele versie van PFSense.
* Deze Firewall heeft NAT uitgeschakeld! NAT is actief op de router Router0.
* Configureer deze firewall zodanig dat enkel die poorten openstaan die echt nodig zijn binnen
uw netwerk.
* Configureer deze firewall zodanig dat je vanuit elk subnet van je netwerk/LAN (zowel de VLANs als de router subnets) kan communiceren met het internet.
# 3.8 Tools voor intern gebruik
Naast het opleveren van netwerkinfrastructuur naar klanten toe, bestaat een deel van het werk van een systeembeheerder ook uit het optimaliseren van het “productieproces”. Voorzie dus dat een deel van de tijd hier aan besteed wordt, en dat dit zichtbaar is in het kanban-bord.
Voorbeelden:
* Opzetten virtualisatie-infrastructuur voor de productie-omgeving;
* Automatiseren van tests, o.a.:
  * Statische analyse van code op stijl en vaak voorkomende fouten (“linting”);
  * Functionele tests op individuele componenten;
* Integratietests;
  * Uitvoeren van geautomatiseerde tests na elke commit of merge;
  * Automatiseren van genereren technische documentatie in de vorm van een e-book of website (zoals readthedocs.io);
  * Schrijven of aanpassen van tools/scripts voor gebruik binnen het project;
  * enz.
