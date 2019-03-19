echo "Installing fileserver features"

Install-WindowsFeature FileAndStorage-Services
Install-WindowsFeature -Name FS-Resource-Manager -IncludeManagementTools
Install-WindowsFeature FS-DFS-Namespace, FS-DFS-Replication, RSAT-DFS-Mgmt-Con
  
echo "Partitioning..."

Resize-Partition -DiskNumber 0 -PartitionNumber 2 -Size 30GB

echo "Creating volumes..."

New-Partition -DiskNumber 0 -Size 500MB -DriveLetter D
Format-Volume -DriveLetter D -FileSystem NTFS
Set-Volume -DriveLetter D -NewFileSystemLabel "VerkoopData"

New-Partition -DiskNumber 0 -Size 500MB -DriveLetter E
Format-Volume -DriveLetter E -FileSystem NTFS
Set-Volume -DriveLetter E -NewFileSystemLabel "OntwikkelingData"

Initialize-Disk 1
  
New-Partition -DiskNumber 1 -Size 500MB -DriveLetter J
Format-Volume -DriveLetter J -FileSystem NTFS
Set-Volume -DriveLetter J -NewFileSystemLabel "ShareVerkoop"
   
New-Partition -DiskNumber 1 -Size 500MB -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS
Set-Volume -DriveLetter F -NewFileSystemLabel "ITData"
   
New-Partition -DiskNumber 1 -Size 500MB -DriveLetter G
Format-Volume -DriveLetter G -FileSystem NTFS
Set-Volume -DriveLetter G -NewFileSystemLabel "DirDATA"

New-Partition -DiskNumber 1 -Size 500MB -DriveLetter H
Format-Volume -DriveLetter H -FileSystem NTFS
Set-Volume -DriveLetter H -NewFileSystemLabel "AdminData"
  
New-Partition -DiskNumber 1 -Size 500MB -DriveLetter Y
Format-Volume -DriveLetter Y -FileSystem NTFS
Set-Volume -DriveLetter Y -NewFileSystemLabel "HomeDirs"
  
New-Partition -DiskNumber 1 -Size 500MB -DriveLetter Z
Format-Volume -DriveLetter Z -FileSystem NTFS
Set-Volume -DriveLetter Z -NewFileSystemLabel "ProfileDirs"


echo "Adding Quota's..."
New-FSRMQuotaTemplate -Name "VerkoopData Quota" -Size 100MB
New-FSRMQuotaTemplate -Name "DirDATA Quota" -Size 100MB
New-FSRMQuotaTemplate -Name "AdminData Quota" -Size 100MB
New-FSRMQuotaTemplate -Name "OntwikkelingData Quota" -Size 200MB
New-FSRMQuotaTemplate -Name "ITData Quota" -Size 200MB



