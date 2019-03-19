#join the domain and be superuser
$domain = "red.local"
$password = "Project2018" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\Administrator"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential