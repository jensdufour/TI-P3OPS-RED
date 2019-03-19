# Testplan taak ZULU2

Auteur(s) testplan: Emiel Marchand

# Preconditie

De test gebeurt op een freeBSD (64-bit) VM. De VM beschikt over 2 ethernet adapters. Een voor het lan netwerk (internpfsense) en een voor het wan netwerk (externpfsense). De machine heeft genoeg met 1 GB RAM.

Een tweede machine binnen hetzelfde netwerk die over een webbrowser beschikt om mee naar de WebGUI te surfen. Op deze machine is ook de .xml file aanwezig om de configuratie te voltooien.

# Testing

Dit test plan test dat de .xml file geen fouten bevat en dat de .xml op een correcte manier is teruggezet.

1. We loggen in op de WebGUI via een machine uit hetzelfde netwerk. Surf naar 172.18.0.69.
2. Log in met username "admin" en wachtwoord "pfsense".
3. Controleer in het dashboard dat de hostnaam is ingesteld (Zulu2.red.local)
4. Ga naar `Firewall --> Rules --> LAN` en controleer als er "pass rules" zijn.
5. Controleer bij `Interfaces` dat beide netwerkinterfaces ingesteld zijn met de juiste IP-adressen:
   - LAN: `172.18.0.69/30`
   - WAN: `172.18.0.74/30`
6. Controleer verder of de WAN-interface ook een IPv4 Upstream gateway address heeft, dit kan je nagaan bij `Interfaces -> WAN`.
7. Controleer of DNS-resolver en DNS-forwarder beide uitgeschakeld zijn, dit kan je nagaan bij `Services -> DNS Resolver en Services -> DNS Forwarder`.
8. Controleer de DNS-servers (`172.18.0.35` en `172.18.0.34`) correct ingesteld staan, dit kan je nagaan bij `System -> General Setup`. Hier kan je ook de Timezone nagaan, dit dient op `Europe/Brussels` te staan.
9. Controleer dat er static routes en gateways zijn geconfigureerd. Dit vind je bij `System --> Routing`


# Postconditie

De Firewall is volledig geconfigureerd.



