#maak GPO RemoveGamesLink aan.
New-GPO -Name RemoveGamesLink

#Link de GPO met de juiste OU's
New-GPLink -Name RemoveGamesLink -target "OU=Administratie,OU=RED,DC=red,dc=local"
New-GPLink -Name RemoveGamesLink -Target "OU=Verkoop,OU=RED,DC=red,dc=local"
New-GPLink -Name RemoveGamesLink -Target "OU=ITAdministratie,OU=RED,DC=red,dc=local"
New-GPLink -Name RemoveGamesLink -Target "OU=Ontwikkeling,OU=RED,DC=red,dc=local"
New-GPLink -Name RemoveGamesLink -Target "OU=Directie,OU=RED,DC=red,dc=local"

#import GPO van een voorafgemaakte Backup voor het moment van men stick. MOET NOG AANGEPAST WORDEN!!!
Import-GPO -BackupID "8AFE8783-48BD-483C-99F9-4E708D9CFBF1" -Path "E:\GPO_Backups" -TargetName "RemoveGamesLink"

#maak GPO DisableControlPanel aan.
New-GPO -Name DisableControlPanel

#Link de GPO met de juiste OU's
New-GPLink -Name DisableControlPanel -target "OU=Administratie,OU=RED,DC=red,dc=local"
New-GPLink -Name DisableControlPanel -Target "OU=Verkoop,OU=RED,DC=red,dc=local"
New-GPLink -Name DisableControlPanel -Target "OU=ITAdministratie,OU=RED,DC=red,dc=local"
New-GPLink -Name DisableControlPanel -Target "OU=Ontwikkeling,OU=RED,DC=red,dc=local"
New-GPLink -Name DisableControlPanel -Target "OU=Directie,OU=RED,DC=red,dc=local"

#import GPO van een voorafgemaakte Backup voor het moment van men stick. MOET NOG AANGEPAST WORDEN!!!
Import-GPO -BackupID "86DE33F5-9AE6-41E7-89EC-D493A8F1E770" -Path "E:\GPO_Backups" -TargetName "DisableControlPanel"


#maak GPO DisableNetwerkAdapter aan.
New-GPO -Name DisableNetwerkAdapter

#Link de GPO met de juiste OU's
New-GPLink -Name DisableNetwerkAdapter -target "OU=Administratie,OU=RED,DC=red,dc=local"
New-GPLink -Name DisableNetwerkAdapter -Target "OU=Verkoop,OU=RED,DC=red,dc=local"

#import GPO van een voorafgemaakte Backup voor het moment van men stick. MOET NOG AANGEPAST WORDEN!!!
Import-GPO -BackupID "707F3281-FF8B-4016-B8BB-D536E14C1B4E" -Path "E:\GPO_Backups" -TargetName "DisableNetwerkAdapter"
