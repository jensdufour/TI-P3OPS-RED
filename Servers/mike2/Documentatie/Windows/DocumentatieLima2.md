# LIMA2

## Script 1

### Installeren van de nodige roles en features

`Install-WindowsFeature FileAndStorage-Services`
`Install-WindowsFeature -Name FS-Resource-Manager -IncludeManagementTools`
`Install-WindowsFeature FS-DFS-Namespace, FS-DFS-Replication, RSAT-DFS-Mgmt-Con`
  
### Resize de partitie (optioneel)

`Resize-Partition -DiskNumber 0 -PartitionNumber 2 -Size 30GB`

### Volumes creëren op Disk 0

`New-Partition -DiskNumber 0 -Size 500MB -DriveLetter D
 Format-Volume -DriveLetter D -FileSystem NTFS
 Set-Volume -DriveLetter D -NewFileSystemLabel "VerkoopData"`

 `New-Partition -DiskNumber 0 -Size 500MB -DriveLetter E
 Format-Volume -DriveLetter E -FileSystem NTFS
 Set-Volume -DriveLetter E -NewFileSystemLabel "OntwikkelingData"`

### Overschakeling naar Disk 1

`Initialize-Disk 1`
  
### Aanmaken van nog meer volumes op een 2de schijf
  
`New-Partition -DiskNumber 1 -Size 500MB -DriveLetter J
 Format-Volume -DriveLetter J -FileSystem NTFS
 Set-Volume -DriveLetter J -NewFileSystemLabel "ShareVerkoop"`
   
 `New-Partition -DiskNumber 1 -Size 500MB -DriveLetter F
 Format-Volume -DriveLetter F -FileSystem NTFS
 Set-Volume -DriveLetter F -NewFileSystemLabel "ITData"`
   
 `New-Partition -DiskNumber 1 -Size 500MB -DriveLetter G
 Format-Volume -DriveLetter G -FileSystem NTFS
 Set-Volume -DriveLetter G -NewFileSystemLabel "DirDATA"`

 `New-Partition -DiskNumber 1 -Size 500MB -DriveLetter H
 Format-Volume -DriveLetter H -FileSystem NTFS
 Set-Volume -DriveLetter H -NewFileSystemLabel "AdminData"`
  
``New-Partition -DiskNumber 1 -Size 500MB -DriveLetter Y
 Format-Volume -DriveLetter Y -FileSystem NTFS
 Set-Volume -DriveLetter Y -NewFileSystemLabel "HomeDirs"``

`New-Partition -DiskNumber 1 -Size 500MB -DriveLetter Z
Format-Volume -DriveLetter Z -FileSystem NTFS
Set-Volume -DriveLetter Z -NewFileSystemLabel "ProfileDirs"`

### Quotas maken

`New-FSRMQuotaTemplate -Name "VerkoopData Quota" -Size 100MB`  
`New-FSRMQuotaTemplate -Name "DirDATA Quota" -Size 100MB`  
`New-FSRMQuotaTemplate -Name "AdminData Quota" -Size 100MB`  
`New-FSRMQuotaTemplate -Name "OntwikkelingData Quota" -Size 200MB`  
`New-FSRMQuotaTemplate -Name "ITData Quota" -Size 200MB`  

## Script 2

### Mappen aanmaken voor de shares

`New-Item -ItemType directory -Path D:\Shares\VerkoopData`  
`New-Item -ItemType directory -Path E:\Shares\OntwikkelingData`  
`New-Item -ItemType directory -Path F:\Shares\ITData`  
`New-Item -ItemType directory -Path G:\Shares\DirDATA`  
`New-Item -ItemType directory -Path H:\Shares\AdminData`  
`New-Item -ItemType directory -Path J:\Shares\ShareVerkoop`  
`New-Item -ItemType directory -Path Y:\Shares\HomeDirs`  
`New-Item -ItemType directory -Path Z:\Shares\ProfileDirs`  

### Shares maken met permissies

`New-Smbshare -name VerkoopData -Path: D:\Shares\VerkoopData -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Verkoop"`  
`New-Smbshare -name OntwikkelingData -Path: E:\Shares\OntwikkelingData -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Ontwikkeling"`  
`New-Smbshare -name ITData -Path: F:\Shares\ITData -EncryptData $False -FullAccess "RED\ITAdministratie"`  
`New-Smbshare -name DirDATA -Path: G:\Shares\DirDATA -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Directie"`  
`New-Smbshare -name AdminData -Path: H:\Shares\AdminData -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Administratie"`  
`New-Smbshare -name ShareVerkoop -Path: J:\Shares\ShareVerkoop -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "everyone"`  
`New-Smbshare -name HomeDirs -Path: Y:\Shares\HomeDirs -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "everyone"`  
`New-Smbshare -name ProfileDirs -Path: Z:\Shares\ProfileDirs -EncryptData $False -FullAccess "RED\ITAdministratie" -ReadAccess "RED\Ontwikkeling" -ChangeAccess "RED\Verkoop"`  
