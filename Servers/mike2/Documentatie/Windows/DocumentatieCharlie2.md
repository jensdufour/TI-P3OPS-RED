## Documentatie Charlie 2

## Manuele installatie

#### PC Hernoemen

We gaan ervan uit dat er een domeincontroller in het netwerk zit, en dat de Exchange windows een IP in de range van de DC heefT. Vul bij DNS het ip adres van de DC in.
1. Ga hiervoor naar de 'File Explorer'.
2. Doe rechtermuisknop op "This PC" en kies "Properties".
3. Onder de tab "Computer Name", kies "Change Settings"
4. Kies als PC naam "REDMAIL".

#### Active Directory joinen

We gaan ervan uit dat er een domeincontroller in het netwerk zit, en dat de Exchange windows een IP in de range van de DC heeft. Vul bij DNS het ip adres van de DC in.
RED.local IP Settings:
- IP: 172.18.0.36
- SM: 255.255.255.224
- DG: 172.18.0.33
- DNS: 172.18.0.34
1. Ga hiervoor naar de 'File Explorer'.
2. Doe rechtermuisknop op "This PC" en kies "Properties".
3. Onder de tab "Computer Name", kies "Change Settings"
4. Kies op het nieuw venster dat opent de tab 'Change'
5. Kies domein, en vul bij domein 'red.local', log in met de administrator van de domein controller.
6. De server is nu gejoind, herstart de server.

(Indien de VM lokaal staat, werken we in het netwerk met een Bridge adapter)

#### Exchange voorbereiden
7.	Maak in Active Directory een user aan met de volgende rechten “Member Of”.
8.	Ga naar “Active Directory Users and Computer”
9.	Maak in “Users” een nieuwe “User” aan. Benoem deze bijvoorbeeld Exchange, en als paswoord bv. Mailserver1
10.	Geef in de “Properties”, “Member of” de volgende rechten:   
    -   Administrators
    -   Domain Admins
    -   Domain Users
    -   Enterprise Admins
    -   Schema admins
11. Log in op de Exchange server, met bovenstaande user op het domein. (RED\Exchange & Mailserver1)
12. Installeer Net.Framework laatste versie (herstart vereist), Microsoft Unified Communications Managed API 4.0 en Visual C++ 2013 Redistributable
13.	Installeer Remote Server Administration Toolkit met volgend PowerShell Command: Install-WindowsFeature RSAT-ADDS (VOER UIT ALS ADMINISTRATOR)
14.	Open vervolgens Command Prompt als administrator, om AD ‘prepare’ uit te voeren. Dit is een belangrijke stap alvorens we Exchange gaan installeren.
a.	Switch naar de gemounte ISO van Exchange (Station F in mijn geval)
b.	Voer “.\Setup /PrepareSchema /IAcceptExchangeServerLicenseTerms” uit
Als dit klaar is.
c.	Voer “.\Setup /Preparead /IAcceptExchangeServerLicenseTerms /OrganizationName:”red” ” uit
15.	Installeer volgende componenten via Powershell: (VOER UIT ALS ADMINISTRATOR)
Install-WindowsFeature NET-Framework-45-Features, RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, RSAT-Clustering-Mgmt, RSAT-Clustering-PowerShell, Web-Mgmt-Console, WAS-Process-Model, Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Lgcy-Mgmt-Console, Web-Metabase, Web-Mgmt-Console, Web-Mgmt-Service, Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-Windows-Auth, Web-WMI, Windows-Identity-Foundation (VOER UIT ALS ADMINISTRATOR)
16.	Herstart de server, log zeker terug in met de Exchange gebruiker.
17.	We beginnen nu de Exchange installatie.
18.	Open de Setup.exe file in de ISO van Exchange (deze kan je mounten). Zet de file zeker LOKAAL op uw server!
19. Klik op de setup.exe
20. Kies ‘Don’t check for updates right now’.
21. Kies 'Next'
22. Accept de 'terms'
23. Kies ‘Don’t use recommended settings’ en ‘next’
24. Vink 'Mailbox Role' aan, en 'Automatically install...', kies NEXT.
25. Kies 'Next'
26. Kies ‘Disable Malware Scanning’ & ‘Next’.
27. Als de Readiness Check; 100% is; kies ‘Install’
28. Eens de installatie is afgerond (kan enige tijd duren), kies “Finish”.

#### Configuratie Exchange:
1.	Om alle problemen met Internet Explorer te vermijden, installeren we Google Chrome met behulp van de .exe file.
2.	Open Google Chrome
3.	Navigeer naar de Beheerdersconsole van Exchange die je terugvindt op het volgende adres: https://{computernaam}/ecp; in mijn geval dus https://redmail/ecp
Geef de server voldoende tijd alles op te starten na een reboot!
4.	Log in als een administrator. Dus RED\Exchange, wachtwoord: Mailserver1 (standaard mailaccoun)
5.	We gaan nu exchange instellen, om mails te kunnen versturen. Ga hiervoor naar “E-mailstroom”, “Connectors verzenden”. 
6.	Klik op het “+”je om een connector toe te voegen.
7.	Vul een naam in; bv. “Send connector”, en kies de optie “Internet”. Kies VOLGENDE.
8.	Kies “MX Record gelinkt aan het domein van de ontvanger”, en klik volgende.
9.	Klik op het ‘+’je om een domein toe te voegen waarnaar je mails wil routeren.
10.	Vul een *je in bij het veld FQDN, en kies vervolgens opslaan.
11.	Kijk de instellingen na, en kies VOLGENDE.  
12.	Klik terug op het ‘+’je om een bronserver toe te voegen.
13.	Voeg de server toe, en kies ‘OK’
14.	Bekijk de instellingen, en kies VOLTOOIEN.  


#### We gaan nu de mails testen, bv. een mail naar jezelf sturen.
1.	Ga naar https://redmail/owa
2.	Log in:
3.	Maak een “nieuwe mail”, stuur deze naar exchange@red.local. 
4. Als het goed is, komt de mail na enkele ogenblikken aan bij jezelf. 

TIP! Troubleshoot het verzenden in de “Beheerdersconsole” onder de tab, “E-mailstroom” -> “Bezorgingsrapporten”. Daar kan je alle mailverkeer gedetailleerd bekijken.
 
1.	Om de mail nogmaals te testen, stuur ik een mail naar een e-mailadres die héél laag staat ingesteld qua beveiliging. We sturen immers vanuit een “invalid domain”, dus vele providers van ontvangers zullen immers mijn mail weigeren.
2.	Ik stuur vanuit de OWA webmail (https://redmail/owa) een mail. Ik gebruik “tekst zonder opmaak” omdat dit nog minder streng wordt aanzien door filters.
3.	We zien dat de mail correct is verzonden.
4.	Het bezorgingsrapport toont normaliter positief resultaat!
5.	Mijn ontvanger heeft mijn mail ook ontvangen in normaal geval.



#### Exchange installeren met de scripts
Deze scripts zijn universeel, je kan desgewenst de domein aanpassen, alsook de username om het domein te joinen.
Wachtwoord wordt gevraagd van zodra je de scripts runt.

**Script - Deel 1:** _IP instellen, domein joinen_ **Zorg ervoor dat je VM bridged is, met de juiste netwerkadapter op je host!**
     
- Na dit script herstart de PC, log in met de domeinadministrator

**Script - Deel 2:** _Mappen voorbereiden voor de setup files + installeren van nodige componenten_

- UCMA moet je hernoemen naar ucma.exe

- Je moet eens script dit vraagt, visual install / .NET / UCMA / chrome.exe in de juiste map "files" plaatsen.

- Voor Exchange moet je alle bestanden uit de ISO kopiëren in de aangemaakte map "exchange".

- Dit script gaat de nodige "componenten" installeren.

- Ga verder in het script eens alles in de juiste mappen staat.

- Herstart ook op het einde.

**Script - Deel 3:** Installeert Exchange. Start dit script na de herstart, en als je weer ingelogd bent met de domeinadministrator. Dit zal alles voor Exchange installeren.

**Configuratie - Deel 4:** Zie "Configuratie Exchange" vanaf puntje 3.