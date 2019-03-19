# Testrapport taak ...

Auteur(s) testrapport: Edward Demey

# Precondities

 * Alfa is correct opgesteld
 * Ingelogd op bravo als domain admin

# Testing

### Servernaam en domein
 * Settings gecontrolleerd op server manager
   1. Naam is ns2
   2. Domein is red.local
### Netwerksettings
 * IpV4 settings van netwerk adapter gecontroleerd
   1. IP is 172.18.0.35 
   2. SM is 255.255.255.224 
   3. Default gateway is 172.18.0.33 
   4. Preferred en alternate dns is ingesteld op ns1 en ns2
   
 ### Roles
  * AD DS en DNS roles staan in server manager
  
 ### Duplicatie Alfa2
  * Duplicatie OU
    1. red.local is aanwezig
    2. Alle sub OU's zijn aanwezig
  * Duplicatie Domain Controllers
    1. Beide entries zijn aanwezig
  * Duplicatie Servers
    1. Alle servers zijn aanwezig bij Computers

