## Configure Firewall Settings for Configuration Manager 2012 R2

**Server Manager - dashboard**, bij Tools klik je op **Group Policy Management**.

Onder Group Policy Management => Forest: red.local => Domains => red.local. Op red.local rechterklik je en kies **Create a GPO in this domain, and Link it here..**. 

Name: Client Push Policy Settings
Source Starter GPO: (none)
Druk: OK

Rechterklik op de policy die je juist aangemaakt hebt: Client Push Policy Settings en kies **Edit**.
                                                                                                                                                                                                                                                                                                                                     
Onder Computer Configuration => Policies => Windows Settings => Security Settings => Windows Firewall with advanced security => Inbound Rules. Rechterklik op Inbound Rules en kies **New Rule...**.

Kies voor Predefined => File and Printer Sharing => Next
Bij Predefined Rules => Alles aan laten staan => Next
Bij Action => Allow the connection => Finish

Rechterklik op **Outbound Rules en kies New Rule...**.

Kies voor Predefined => File and Printer Sharing => Next
Bij Predefined Rules => Alles aan laten staan => Next
Bij Action => Allow the connection => Finish

Rechterklik op **Inbound Rules en kies New Rule...**.

Kies voor Predefined => Windows Management Instrumentation(WMI) => Next
Bij Predefined Rules => Alles aan laten staan => Next
Bij Action => Allow the connection => Finish

## Open Ports for SQL Replication

Onder Group Policy Management => Forest: red.local => Domains => red.local. Op red.local rechterklik je en kies **Create a GPO in this domain, and Link it here..**. 

Name: SQL Ports For SCCM 2012 R2
Source Starter GPO: (none)

Rechterklik op de policy die je juist aangemaakt hebt: SQL Ports For SCCM 2012 R2 en kies **Edit**.

Onder Computer Configuration => Policies => Windows Settings => Security Settings => Windows Firewall with advanced security => Inbound Rules. Rechterklik op Inbound Rules en kies **New Rule...**.

Kies voor Port => Next
Kies voor TCP en Specific local ports : 1433
Bij Action => Allow the connection => Next
Bij Profile => Check Domain, Private, Public aan.
Bij Name => TCP Inbound 1433

Onder Computer Configuration => Policies => Windows Settings => Security Settings => Windows Firewall with advanced security => Inbound Rules. Rechterklik op Inbound Rules en kies **New Rule...**.

Kies voor Port => Next
Kies voor TCP en Specific local ports : 4022
Bij Action => Allow the connection => Next
Bij Profile => Check Domain, Private, Public aan.
Bij Name => TCP Inbound 4022

Nadien voer je het commando: gpupdate /force uit op de CMD prompt. 

Na dit commando typ je: rsop.msc en dit zal je alle GPO names laten zien. Je kan dit sluiten zonder op te slaan. Nu is dit goed geconfigureerd.
