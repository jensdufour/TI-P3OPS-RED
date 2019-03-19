#Declaring variables
$hostname = "ns1"

#Computer naam wijzigen --> Standaard: ALFA2 (Change to ns1?)
Rename-Computer -ComputerName $env:COMPUTERNAME  -newName $hostname -Force -Restart