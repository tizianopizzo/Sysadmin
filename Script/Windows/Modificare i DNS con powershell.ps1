Get-DnsClientServerAddress -AddressFamily IPv4 -InterfaceAlias Ethernet*  | Set-DnsClientServerAddress -ServerAddresses ("1.1.1.1,8.8.8.8")
