# Testrapport ALFA 2

Auteur(s) testrapport: Tristan Henderick.


### Server Configuratie
 * kijk in server manager, als AD DS en DNS staan bij ROLES AND SERVER GROUPS is de DC goed geïnstalleerd.
 
 klopt, test geslaagd
 
 * Test volgende configuratie in powershell.
   * Vraag het ip adres op met het commando "ipconfig", dit moet overeenkomen met  IP: 172.18.0.34/27 & Default Gateway: 172.18.0.33
   
   - test geslaagd
   
   * Vraag de servernaam op met het commando "hostname", deze moet ns1 zijn
   
   - test geslaagd
   
   * Controleer de domain name met het commando: "(Get-WmiObject Win32_ComputerSystem).Domain". Dit moet red.local zijn.
   
   - test geslaagd
   
   
	
### Domein Configuratie

 * Kijk of de groepen correct zijn aangemaakt met het commando  
 `Get-ADGroup -filter * -searchbase "OU=RED,dc=RED,dc=local"`. Dit zijn de groepen die we hebben aangemaakt.
 
 - test geslaagd
 
 * Kijk of users correct zijn aangemaakt met het commando  
 `Get-ADUser -filter * -searchbase "OU=RED,dc=RED,dc=local"`
 
 - test geslaagd
 
 * Ga in het start menu naar `windows administrative tools` en kies voor `Group Policy Management`, klap de `forest`, `domain`, `red.local`, `RED` en kijk bij elke groep of die zijn policies heeft.
 
 - test geslaagd
 
 * Log in met een user uit de groep administratie, kijk of alle policies correct geimplementeerd zijn (kan enkel via andere server of client) (voorlopig)
 
 - voorlopig nog niet mogelijk
