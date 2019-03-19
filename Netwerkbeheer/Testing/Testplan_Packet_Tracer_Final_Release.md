# Testplan: Netwerk

Auteur(s) testplan : Tristan Henderick.

## Requirements

Er is een template voorzien in de vorm van een packet tracer file. Deze bevindt zich onder https://github.com/HoGentTIN/p3ops-red/tree/master/Netwerkbeheer/Network_Layout.pkt

De configuratiescripts voor de devices bevinden zich onder https://github.com/HoGentTIN/p3ops-red/tree/master/Netwerkbeheer/Config. 

Download alle nodige bestanden en zorg dat u de recentste versie van Packet Tracer heeft.

## Testplan

om te beginnen open het packet tracer bestand "Network_Layout.pkt"

voor elke Router en Switch volg je de volgende stappen:

-open de interface door te klikken op het toestel.

-klik op de tab "config"

-bij "Startup Config" klik op de knop "Load..."

-geef voor elk toestel het pad van het passende startup config bestand in.

-klik op de tab "CLI"

-voer volgende commando's in:

```
enable

reload

```

indien nodig de wachtwoorden vind u onder https://github.com/HoGentTIN/p3ops-red/blob/master/Netwerkbeheer/Documentatie.md


## Tests

test interVLAN routing:

- klik op server-PT alfa2
- klik op de tab "Desktop"
- voer het volgende commando in:

```
ping 172.18.0.5

```
    
- indien nodig kan je in packter tracer op de knop "fast forward" klikken om het wat rapper te laten gaan
    
- soms zal je het commando een 2e keer moeten uitvoeren voor het werkt.
    
- als de pings succesvol verlopen dan is er connectiviteit tussen VLAN 500 en VLAN 300
    
- we doen hetzelfde om connectiviteit tussen VLAN 500 en VLAN 200 te testen
    
```

ping 172.18.2.6

```

- als laatste testen we connectiviteit tussen VLAN 300 en VLAN 200

- klik op Server-PT Kilo2
- klik op de tab "Desktop"
- voer het volgende commando in:
    
```

ping 172.18.2.6

```
    


test interdomain routing:

- klik op server-PT alfa2
- klik op de tab "Desktop"
- voer het volgende commando in:

```

ping 172.16.0.3

```

- indien nodig kan je in packter tracer op de knop "fast forward" klikken om het wat rapper te laten gaan

- soms zal je het commando een 2e keer moeten uitvoeren voor het werkt.

- als de pings succesvol zijn dan is er connectiviteit tussen de domeinen.
    
