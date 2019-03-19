# Testrapport ALFA 2

Auteur(s) testrapport: Tristan Henderick.


### Server Configuratie
 * kijk in server manager, als AD DS en DNS staan bij ROLES AND SERVER GROUPS is de DC goed geïnstalleerd.
 
 AD DS en DNS zijn correct geïnstalleerd.
 
 * Test de basisconfiguratie aan de hand van het testscipt
   	- De 2 test voor DNS falen, alle andere tests slagen.
   
   	![Screenshot](./Alfa2Test.PNG)
   
   
	
### Domein Configuratie

 * Kijk of de groepen correct zijn aangemaakt met het commando  
 `Get-ADGroup -filter * -searchbase "OU=RED,dc=RED,dc=local"`. Dit zijn de groepen die we hebben aangemaakt.
 
 	- De groepen Adminstratie, Directie, ITAdministratie, Ontwikkeling en Verkoop worden weergegeven.

  	![Screenshot](./TestADGroup.PNG)

 
 * Kijk of users correct zijn aangemaakt met het commando  
 `Get-ADUser -filter * -searchbase "OU=RED,dc=RED,dc=local"`
 
 	- Users worden getoond

  	![Screenshot](./TestADUser.PNG)
 
 * Ga in het start menu naar `windows administrative tools` en kies voor `Group Policy Management`, klap de `forest`, `domain`, `red.local`, `RED` en kijk bij elke groep of die zijn policies heeft.
 
 	- Iedere groep heeft de correcte policies
 
 * Log in met een user uit de groep administratie, kijk of alle policies correct geimplementeerd zijn (kan enkel via andere server of client) (voorlopig)
 
 	- voorlopig nog niet mogelijk

### Opmerking

 - Verwachte output voor domein configuratie staat niet in testplan
