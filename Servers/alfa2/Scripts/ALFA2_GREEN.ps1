#Reverse lookup zone aanmaken
Add-DnsServerPrimaryZone -NetworkId '172.18.0.0/16' -ReplicationScope 'Forest'

#Alias voor alfa, bravo en delta
Add-DnsServerResourceRecordCName -Name "www" -HostNameAlias "Delta2.red.local" -ZoneName "red.local"
Add-DnsServerResourceRecordCName -Name "alfa2" -HostNameAlias "ns1.red.local" -ZoneName "red.local"
Add-DnsServerResourceRecordCName -Name "bravo2" -HostNameAlias "ns2.red.local" -ZoneName "red.local"
Add-DnsServerResourceRecordCName -Name "mail" -HostNameAlias "CHARLIE2.red.local" -ZoneName "red.local"
Add-DnsServerResourceRecordA -Name "" -ZoneName "red.local" -IPv4Address "172.18.0.37"

#Support voor red.be
Add-DnsServerPrimaryZone -Name "red.be" -ReplicationScope Forest
Add-DnsServerResourceRecordA -Name "" -ZoneName "red.be" -IPv4Address "172.18.0.37"
Add-DnsServerResourceRecordCName -Name "www" -HostNameAlias "Delta2.red.local" -ZoneName "red.local"

#Forward zone voor green aanmaken
Add-DnsServerSecondaryZone -Name 'green.local' -ZoneFile 'green.local.dns' -MasterServers 172.16.0.40