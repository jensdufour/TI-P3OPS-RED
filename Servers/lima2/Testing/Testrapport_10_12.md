# Testrapport taak LIMA2

Auteur(s) testrapport: Bert Provoost

# Precondities

LIMA2 is geïnstalleerd en geconfigureerd.  
AFA2 is geïnstalleerd en geconfigureerd.  
Client pc is geïnstalleerd en domain gejoined.  

# Testen

1) Log in met een gebruiker uit de ... groep.  

 * ingelogd met BertProvoost@red.local

2) Open File Explorer en ga naar \\\172.18.0.3  

  * Deze test is geslaagd.

    ![image](https://user-images.githubusercontent.com/17174277/49725981-3c69c680-fc6d-11e8-9bfa-6ff7a9c3c50d.png)

3) U moet alle shares zien maar enkel maar toegang hebben tot de desbetreffende share(s).  
merk op: HomeDirs en ProfileDirs zijn voor iedereen toegankelijk.

 * Ik heb toegang tot VerkoopData, ShareVerkoop, Users, ProfileDirs, HomeDirs. Alle andere folders zijn geblokeerd.
 ![image](https://user-images.githubusercontent.com/17174277/49726150-9e2a3080-fc6d-11e8-85ee-0609203b0b87.png)
