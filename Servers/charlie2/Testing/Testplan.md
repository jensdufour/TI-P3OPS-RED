# Testplan taak ...

Auteur(s) testplan: Cedric De Witte

# Preconditie
- alfa2 is correct geconfigureerd en operationeel.<br>
- Je hebt een mailbox ontvangen in de Active Directory. Log in met je accountnaam: <br>
    *Account name: RED\(accountnaam)* <br>
    *Password: -uw wachtwoord-* <br>
  <br> 
- Ter test gebruik je accountnaam "bertprovoost" en als wachtwoord "P@ssword".

# Testing
1. Ga naar Google Chrome op een Windows Client in het domein, en navigeer naar de OWA webmail (https://redmail/owa).
2.	Log in met uw Active Directory mailaccount:
 *Account name: RED\(accountnaam)* <br>
    *Password: -uw wachtwoord-* <br>
3. Stel de tijdzone correct in indien dit wordt gevraagd.
4. Stuur een mail naar administrator@red.local, hij zou deze mail moeten ontvangen. Je kan ook mailen naar TEAM GREEN. Als alles correct is bij hen, ontvangen zij deze mail.
5. Extern mailen moet ook lukken, alhoewel dit wel geblokkeerd wordt binnen de HoGent site.