# Testrapport ALFA 2

Auteur(s) testrapport: Tristan Henderick, Tommy Veevaete.

# Preconditie
 * Server bestaat, Windows Server 2016 is geïnstalleerd
 * server heeft 1 NAT adapter en 1 Netwerk Bridge adapter.

# Postconditie
 * DC Services zijn geïnstalleerd
 * DNS is juist ingesteld
 * Domeinconfiguratie voltooid:
   * 5 groepen zijn aangemaakt (en bijhorende OU)
   * Een aantal users zijn aangemaakt en toegekend aan groepen
   * De volgende policies worden toegepast
     * Control panel uitgeschakeld
     * Games link verwijderd
     * Administratie en Verkoop hebben geen toegang tot netwerkadapters.  
   * Aliassen zijn goed ingesteld.


# Testing

### Server Configuratie
 * kijk in server manager, als AD DS en DNS staan bij ROLES AND SERVER GROUPS is de DC goed geïnstalleerd.
 
     - ADDS en DNS roles zijn geïnstalleerd.
 
 ![](https://i.imgur.com/fUgRUfq.png)
 
 
 * Test volgende configuratie in powershell.
   * Vraag het ip adres op met het commando "ipconfig", dit moet overeenkomen met  IP: 172.18.0.34/27 & Default Gateway: 172.18.0.33
       - IP adres komt overeen met IP schema
   * Vraag de servernaam op met het commando "hostname", deze moet ns1 zijn
       - Hostname komt overeen met ns1
   * Controleer de domain name met het commando: "(Get-WmiObject Win32_ComputerSystem).Domain". Dit moet red.local zijn.
      - domain name komt overeen met red.local
   
   ![](https://i.imgur.com/7sPh7Vv.png)
   
 * Test op een andere server of die internet heeft. Als dit het geval is is de DNS goed geconfigureerd.
     - alle andere servers hebben toegang tot internet
 * Als Delta2 is geïnstalleerd moet je kunnen surfen naar www.red.be of www.red.local.
     - beide websites zijn bereikbaar
 * Als Charlie is geïnstalleerd moet je kunnen surfen naar mail.red.local.
     - mail.red.local is bereikbaar

### Domein Configuratie

 * Kijk of de groepen correct zijn aangemaakt met het commando  
 `Get-ADGroup -filter * -searchbase "OU=RED,dc=RED,dc=local"`. Dit zijn de groepen die we hebben aangemaakt.
 
     - groups zijn aangemaakt
 
 ![](https://i.imgur.com/EW0h4hm.png)
 
 
 * Kijk of users correct zijn aangemaakt met het commando  
 `Get-ADUser -filter * -searchbase "OU=RED,dc=RED,dc=local"`
 
    - users zijn aangemaakt
 
 ![](https://i.imgur.com/ezgtvan.png)
 
 
 * Ga in het start menu naar `windows administrative tools` en kies voor `Group Policy Management`, klap de `forest`, `domain`, `red.local`, `RED` en kijk bij elke groep of die zijn policies heeft.
 
    - group policies zijn aanwezig
 
 ![](https://i.imgur.com/wckze8S.png)
 
 * Log in met een user op een client pc (account: BertProvoos@red.local, password: P@ssword). kijk of alle policies correct geïmplementeerd zijn.
  	* open in het startmenu control panel. Dit moet geblokkeerd zijn.
    
      - control panel wordt geblokkeerd door GPO
    
    ![](https://i.imgur.com/gt6xim3.png)
    
  	* rechtsklik op het internet icoon en open netwerkinstellingen. Dit moet geblokkerd zijn (Verkoop en Administratie hebben hiervoor geen toegang. Bert provoost is een user van verkoop).
 	  
      - netwerkinstellingen worden geblokkeerd door GPO
    
    ![](https://i.imgur.com/gt6xim3.png)
    
  * open in het startmenu de store. Deze mag niet werken.
   
    - store wordt geblokkeerd door GPO
   
  ![](https://i.imgur.com/1gjzjfR.png)
