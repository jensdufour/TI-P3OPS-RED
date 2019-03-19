#Vars
$hostname = "KILO2"

#Change hostname to KILO2
Rename-Computer -ComputerName $env:COMPUTERNAME  -newName $hostname -Force -Restart