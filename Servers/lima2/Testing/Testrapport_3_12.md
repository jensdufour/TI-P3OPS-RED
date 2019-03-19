# Testrapport taak LIMA2

Auteur(s) testrapport: Edward Demey, Bert Provoost

# Precondities

Een vagrantfile is nodig om een clean install uit te voeren.  
De gebruikte box is : jborean93/Windows2016

Opmerking: Sinds dat er één van de testen vraagt om te pingen naar alfa2/bravo2, zou ' alfa2/bravo2 (die volledig opgezet is) is online op het netwerk ' als een preconditie moeten staan
# Testen

1. Powershell opent

2. Voer een ping uit naar ALFA2, deze zou moeten slagen: > ping 172.18.0.34
 - Success
 
3. Voer een ping uit naar BRAVO2, deze zou moeten slagen: > ping 172.18.0.35
 - Lukt niet, bravo2 staat nog niet op 
 
4. Controleer alle volumes op de fileserver: > Get-Volume
 - Alle aangemaakte volumes zijn zichtbaar
 - Success
 
5. Controlleer alle quotas op de fileserver: > Get-FsrmQuotaTemplate    
 - Ziet er in orde uit

6. Controleer alle shares op de fileserver: > Get-FileShare
 - Alle shares zijn aanwezig
 - Success