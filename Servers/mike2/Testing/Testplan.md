# Testplan taak: mike2

Auteur(s) testplan: Jens Pieters, Edward Demey

# Preconditie

 * Server bestaat, Windows Server 2016 is geïnstalleerd
 
# Postconditie

 * Sharepoint is geïnstalleerd op de server.
 * Sharepoint configuratie is correct, er wordt verwezen naar November2 voor de database.

# Testing

### Server Configuratie
Controleer of de volgende instellingen correct aangepast zijn.
 * De naam van de server is Mike2
   * Gebruik het commando `hostname`
 * Het ip adres is ingesteld op 172.18.0.4/27, met als default gateway 172.18.0.1
   * Gebruik het commando `ipconfig`
 * De firewall is uitgeschakeld
 * De server heeft het domein red.local gejoined

### Sharepoint
Controleer of de installatie en configuratie van SharePoint correct verlopen is.
 * Er is toegang tot SharePoint manager
   * Ga naar `http://mike2:9999/` op de server (?)
 * Er is toegang tot webpagina http://mike2:8080/ die aangemaakt is met SharePoint
   * op de sharepoint server
   * op een andere server/client in het domein
 * De SharePoint webpagina bevat de documentatie van de servers in het domein ()
   
 
