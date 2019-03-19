echo "Creating directories..."
New-Item -ItemType directory -Path D:\Shares\VerkoopData
New-Item -ItemType directory -Path E:\Shares\OntwikkelingData
New-Item -ItemType directory -Path F:\Shares\ITData
New-Item -ItemType directory -Path G:\Shares\DirDATA
New-Item -ItemType directory -Path H:\Shares\AdminData
New-Item -ItemType directory -Path J:\Shares\ShareVerkoop
New-Item -ItemType directory -Path Y:\Shares\HomeDirs
New-Item -ItemType directory -Path Z:\Shares\ProfileDirs

echo "Creating shares..."
New-Smbshare -name VerkoopData -Path: D:\Shares\VerkoopData -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Verkoop"
New-Smbshare -name OntwikkelingData -Path: E:\Shares\OntwikkelingData -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Ontwikkeling"
New-Smbshare -name ITData -Path: F:\Shares\ITData -EncryptData $False -FullAccess "RED\ITAdministratie"
New-Smbshare -name DirDATA -Path: G:\Shares\DirDATA -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Directie"
New-Smbshare -name AdminData -Path: H:\Shares\AdminData -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "RED\Administratie"
New-Smbshare -name ShareVerkoop -Path: J:\Shares\ShareVerkoop -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "everyone"
New-Smbshare -name HomeDirs -Path: Y:\Shares\HomeDirs -EncryptData $False -FullAccess "RED\ITAdministratie" -ChangeAccess "everyone"
New-Smbshare -name ProfileDirs -Path: Z:\Shares\ProfileDirs -EncryptData $False -FullAccess "RED\ITAdministratie" -ReadAccess "RED\Ontwikkeling" -ChangeAccess "RED\Verkoop"