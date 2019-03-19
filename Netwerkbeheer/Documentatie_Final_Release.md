## Stappenplan opstelling netwerk

### Stap 1: Fysieke bekabeling

  stel de fysieke bekabeling in voor elk toestel zoals beschreven in het [IP schema](https://github.com/HoGentTIN/p3ops-red/blob/master/Netwerkbeheer/IP%20Schema_Final_Release.md)
  
  We gebruiken `Switch2.1 - 2.3` en `Router2.1 - 2.3.`.
  
  | Fysieke naam | red.local naam |
  | - | - |
  | Switch2.1 | Switch4  |
  | Switch2.2 | Switch5 (VLAN300) |
  | Switch2.3 | Switch6 (VLAN 500) |
  | Router2.1 | Router1 |
  | Router2.2 | Router3 |
  | Router2.3 | Router4 |
  
De verbindingen zijn beschreven in het IP schema. Refereer naar daar voor de bekabeling.

Belangrijke bekabeling is de verbinding van de servers naar de switches.

In Switch5&6 zijn `Fa0/1-2` voorzien voor de verbinding met de servers. Op de servers zijn dit de 2e en 3e poorten die hiervoor gebruikt worden. Elke server heeft 1 verbinding met 1 switch, de poort is niet van belang.
  
### Stap 2: Configuratie
  
  voor switch 5 & 6 ga je eerst de volgende commando's moeten uitvoeren:
  ```
  enable
  configure terminal
  sdm prefer lanbase-routing
  exit
  write
  reload
  ```
  vervolgens ga je voor elk toestel de configuratie kopieren uit hun backup files.
  Deze vind je hier: https://github.com/HoGentTIN/p3ops-red/tree/master/Netwerkbeheer/Config
  
  
  Eens je de config gekopieerd hebt voer je best vanuit de privileged exec mode het commando `write` uit om de config op te slaan.
  
### Passwords

  Op de routers en switches zijn wachtwoorden voorzien ter beveiliging.
  Het console wachtwoord is `project3`, het enable wachtwoord is `teamred`. Dit geldt ook voor Router4.

# Bronnen

- https://kb.vmware.com/s/article/1004074
- https://community.cisco.com/t5/switching/cisco-c2960-compact-and-ip-routing/td-p/1911873
