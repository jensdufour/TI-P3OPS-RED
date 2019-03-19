#DNS Forwarder definiëren
 #DNS van klasnetwerk
Add-DnsServerForwarder -IPAddress 172.22.0.2
 #DNS van google (mocht bovenstaande niet werken)
Add-DnsServerForwarder -IPAddress 8.8.8.8

New-ADOrganizationalUnit -Name "RED"

#Sub OU aanmaken
New-ADOrganizationalUnit -Name "Administratie" -Path "OU=RED,DC=red,DC=local";
New-ADOrganizationalUnit -Name "Directie" -Path "OU=RED,DC=red,DC=local";
New-ADOrganizationalUnit -Name "ITAdministratie" -Path "OU=RED,DC=red,DC=local";
New-ADOrganizationalUnit -Name "Ontwikkeling" -Path "OU=RED,DC=red,DC=local";
New-ADOrganizationalUnit -Name "Verkoop" -Path "OU=RED,DC=red,DC=local";
New-ADOrganizationalUnit -Name "Werkstations" -Path "OU=RED,DC=red,DC=local";

#Groepen aanmaken
$administratie = New-ADGroup -Name "Administratie" -SamAccountName "Administratie" -GroupCategory Security -GroupScope Global -DisplayName "Administratie" -Path "OU=Administratie,OU=RED,DC=red,DC=local" -PassThru
$directie = New-ADGroup -Name "Directie" -SamAccountName "Directie" -GroupCategory Security -GroupScope Global -DisplayName "Directie" -Path "OU=Directie,OU=RED,DC=red,DC=local" -PassThru
$itadministratie = New-ADGroup -Name "ITAdministratie" -SamAccountName "ITAdministratie" -GroupCategory Security -GroupScope Global -DisplayName "ITAdministratie" -Path "OU=ITAdministratie,OU=RED,DC=red,DC=local" -PassThru
$ontwikkeling = New-ADGroup -Name "Ontwikkeling" -SamAccountName "Ontwikkeling" -GroupCategory Security -GroupScope Global -DisplayName "Ontwikkeling" -Path "OU=Ontwikkeling,OU=RED,DC=red,DC=local" -PassThru
$verkoop = New-ADGroup -Name "Verkoop" -SamAccountName "Verkoop" -GroupCategory Security -GroupScope Global -DisplayName "Verkoop" -Path "OU=Verkoop,OU=RED,DC=red,DC=local" -PassThru

#Users aanmaken

#Create user in Administratie
$user = New-AdUser  -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force)  -DisplayName "Steven Anno" -Name "Steven Anno" -Path "OU=Administratie,OU=RED,DC=red,DC=local" -Surname "Anno" -GivenName "Steven" -UserPrincipalName ("StevenAnno"+"@red.local") -Enabled $true -ChangePasswordAtLogon $false -PassThru
Add-ADGroupMember $administratie -Members $user;

#Create user in Directie
$user = New-AdUser  -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force)  -DisplayName "Thor Nicolai" -Name "Thor Nicolai" -Path "OU=Directie,OU=RED,DC=red,DC=local" -Surname "Nicolai" -GivenName "Thor" -UserPrincipalName ("ThorNicolai"+"@red.local") -Enabled $true -ChangePasswordAtLogon $false -PassThru
Add-ADGroupMember $directie -Members $user;

#Create user in IT Administratie
$user = New-AdUser  -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force)  -DisplayName "Emiel Marchand" -Name "ITAdministratie User" -Path "OU=ITAdministratie,OU=RED,DC=red,DC=local" -Surname "Marchand" -GivenName "Emiel" -UserPrincipalName ("EmielMarchand"+"@red.local") -Enabled $true -ChangePasswordAtLogon $false -PassThru
Add-ADGroupMember $itadministratie -Members $user;
$user = New-AdUser  -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force)  -DisplayName "Exchange Server" -Name "Exchange Server" -Path "OU=ITAdministratie,OU=RED,DC=red,DC=local" -Surname "Server" -GivenName "Exchange" -UserPrincipalName ("ExchangeServer"+"@red.local") -Enabled $true -ChangePasswordAtLogon $false -PassThru
Add-ADGroupMember $itadministratie -Members $user;
Add-ADPrincipalGroupMembership -Identity $user -MemberOf Administrators, 'Domain Admins', 'Enterprise Admins', 'Schema Admins';

#Create user in Ontwikkeling
$user = New-AdUser  -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force)  -DisplayName "Sam Strobbe" -Name "Sam Strobbe" -Path "OU=Ontwikkeling,OU=RED,DC=red,DC=local" -Surname "Strobbe" -GivenName "Sam" -UserPrincipalName ("SamStrobbe"+"@red.local") -Enabled $true -ChangePasswordAtLogon $false -PassThru
Add-ADGroupMember $ontwikkeling -Members $user;

#Create user in Verkoop
$user = New-AdUser  -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force)  -DisplayName "Bert Provoost" -Name "Bert Provoost" -Path "OU=Verkoop,OU=RED,DC=red,DC=local" -Surname "Provoost" -GivenName "Bert" -UserPrincipalName ("BertProvoost"+"@red.local") -Enabled $true -ChangePasswordAtLogon $false -PassThru
Add-ADGroupMember $verkoop -Members $user;
