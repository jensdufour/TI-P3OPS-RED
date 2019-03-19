# Opstart/Installatie

## Opgelet in het script wordt er rekening gehouden met een 2de disk die ik manueel heb toegevoegd

### Script 1

* Voer het eerste script uit, dit zal de volgende zaken uitvoeren:
  * de nodige roles en features installeren.
  * de nodige partities resizen.
  * volumes creëren.
  * quota templates toevoegen.
 
### Script 2 (dit script wordt pas uitgevoerd na de domain join)
 
 * Voer het tweede script uit, dit zal de volgende zaken uitvoeren:
   * directories aanmaken voor de shares.
   * shares aanmaken met de nodige permissies.
 
### Next
 
 * Voeg de quotas toe aan de shares.
 * Kies shadow copies voor de gewenste volumes.
