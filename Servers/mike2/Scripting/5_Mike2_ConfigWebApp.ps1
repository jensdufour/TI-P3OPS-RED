# Add Snap-in Microsoft.SharePoint.PowerShell if not already loaded, continue if it already has been loaded
Add-PsSnapin "Microsoft.SharePoint.PowerShell" -EA 0
 
#Variables
#The Application Pool domain account, must already be created as a SharePoint managed account
$AppPoolAccount = "RED\Administrator" 
#This will create a new Application Pool
$ApplicationPoolName ="SharePoint - 8080" 
#Content DB
$ContentDatabase = "WSS_Content_SharePoint" 
#Alias of your DB Server
$DatabaseServer = "November2" 
#The name of your new Web Application
$WebApp = "http://mike2/"
#The IIS host header
$Url = $WebApp
$Name = "Documenten"
$Description = "SharePoint 2016 Publishing Site"
$Email = "administrator@red.local"
#The path to IIS directory
$IISPath = "C:\inetpub\wwwroot\wss\VirtualDirectories\8080" 
$SiteCollectionTemplate = 'STS#0'
 
New-SPWebApplication -ApplicationPool $ApplicationPoolName `
                     -ApplicationPoolAccount (Get-SPManagedAccount $AppPoolAccount) `
                     -Name $Description `
                     -AuthenticationProvider (New-SPAuthenticationProvider -UseWindowsIntegratedAuthentication) `
                     -DatabaseName $ContentDatabase `
                     -DatabaseServer $DatabaseServer `
                     -Path $IISPath `
                     -Port 8080 `
                     -URL $Url


New-SPSite -Url "http://mike2:8080/" `
           -Name $Name `
           -Description $Description `
           -OwnerAlias $AppPoolAccount `
           -Template $SiteCollectionTemplate

           
	##	   -OwnerEmail $Email `
		   
$w = Get-SPWebApplication "http://mike2:8080/"
$w.Properties["portalsuperuseraccount"] = $AppPoolAccount
$w.Properties["portalsuperreaderaccount"] = $AppPoolAccount
$w.Update()