# Testrapport taak ...

Auteur(s) testrapport: Tristan Henderick

# Precondities

server bestaat, windows server 2016 is geinstalleerd.

# Testing

ik volg de stappen beschreven in tesplan.md

enkele fouten in de stappen van het testplan:

---
Open weer onder "User Configuration" de "policies", klap "Administrative Templates:..." uit en klap "Network" uit en klik op "Network Connections".

Rechtsklik op "Prohibit access to Control Panel and PC settings" en kies voor edit.

---
dit moet zijn "Prohibit access to properties of a LAN connection"

verder enkele kleine schrijffouten.

Na de stappen in het testplan uitgevoerd te hebben test ik de configuratie

Server Configuratie

    Vraag het ip adres op met het commando ipconfig, dit moet overeenkomen met IP: 172.18.0.34/27 & DG: 172.18.0.33
    
    test succesvol uitgevoerd en geslaagd
    
    Vraag de servernaam op met het commando Get-Computername, deze moet ns1 zijn
    
    Get-Computername word niet erkend als cmdlet; hostname werkt wel en geeft ook ns1 als resultaat.
    
    Controleer of DC correct ingesteld is, login scherm moet het domein tonen
    
    niet echt duidelijk welke stappen er verwacht worden dat ik volg om naar het login scherm te komen, maar powershell cmdlet "(Get-WmiObject Win32_ComputerSystem).Domain" werkt hier en geeft red.local als resultaat.Get
    

Domein Configuratie

    Kijk of de groepen correct zijn aangemaakt met Get-ADGroup
    
    commando ontbreekt wat parameters; "Get-ADGroup -filter *" toont alle groepen, de laatste 5 op de lijst zijn degene die in het testplan aangemaakt zijn.
    
    Kijk of users correct zijn aangemaakt met Get-ADUser
    
    Weeral gebrek aan parameters in het cmdlet; Get-ADUser "Surname -like '*User'" geeft een lijst weer van alle users aangemaakt in het testplan.
    
    Log in met een user uit de groep administratie, kijk of alle policies correct geimplementeerd zijn (kan enkel via andere server of client)
    
    kan voorlopig nog niet getest worden
