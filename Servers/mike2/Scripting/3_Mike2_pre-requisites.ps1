# De pre-requisites staan op de github
# De .iso File staat lokaal bij (Jens Pieters) deze is namelijk 3.1GB groot

# voor een goed verloop van de installatie zorg je voor een aantal zaken
# 1. de .iso en het powershell script staan lokaal, bv. onder documents
# 2. zorg voor administrator rights


# voer msodbsql.msi uit voor uitvoeren script -- to resolve dead link problem
# voer volgend commando uit in een CMD gestart met administrator rights
# msodbcsql.msi IACCEPTMSODBCSQLLICENSETERMS=YES /quiet /norestart


$SharePoint2016Path = "C:\prerequisites"
Start-Process "F:\PrerequisiteInstaller.exe" –ArgumentList "/SQLNCli:$SharePoint2016Path\sqlncli.msi /IDFX11:$SharePoint2016Path\MicrosoftIdentityExtensions-64.msi /Sync:$SharePoint2016Path\Synchronization.msi /AppFabric:$SharePoint2016Path\WindowsServerAppFabricSetup_x64.exe /MSIPCClient:$SharePoint2016Path\setup_msipc_x64.exe /WCFDataServices56:$SharePoint2016Path\WcfDataServices.exe /DotNetFx:$SharePoint2016Path\NDP453-KB2969351-x86-x64-AllOS-ENU.exe /MSVCRT11:$SharePoint2016Path\vcredist_x64.exe /MSVCRT14:$SharePoint2016Path\vc_redist.x64.exe /KB3092423:$SharePoint2016Path\AppFabric-KB3092423-x64-ENU.exe"

# bij uitvoeren zal installer vragen voor een 'restart'
# Dit kan zorgen voor problemen aangezien hij wilt voortdoen nadat hij heropgestart is
# Na de heropstart is de .iso niet meer gemount en dit is een probleem
# je kan dit oplossen: je mount de .iso weer en je voor volgend commando uit:
# PS F:\> .\prerequisiteinstaller.exe /continue
# bij dit voorbeeld heb ik als voorbeeld de F-drive genomen waar de .iso gemount is