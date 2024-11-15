#Installazione modulo Exchange online
Set-ExecutionPolicy Unrestricted -Scope Process
Install-Module -Name ExchangeOnlineManagement

#Connessione Exchange Online
Connect-ExchangeOnline

#DKIM script
$Dominio="dominio.it"
#Disabilita la firma DKIM
New-DkimSigningConfig -DomainName $Dominio -Enabled $false
Start-Sleep 1
#Mostra i selector DKIM, devono essere presenti nel DNS pubblico
Get-DkimSigningConfig -Identity $Dominio | Format-List Selector1CNAME, Selector2CNAME
Start-Sleep 1
#Abilita la firma DKIM per il dominio
Set-DkimSigningConfig -Identity $Dominio -Enabled $true
Start-Sleep 3
#Per avere un resoconto di tutti i domini
Get-DkimSigningConfig

#Lingua e impostazioni internazionali mailbox
#Verifica impostazioni internazionali mail singola
Get-MailboxRegionalConfiguration mail@dominio.it | FL
Get-MailboxRegionalConfiguration mail@dominio.it
#Nel caso si voglia cambiare la lingua a tutte le caselle
Get-Mailbox | Set-MailboxRegionalConfiguration -DateFormat dd/MM/yyyy -TimeFormat HH:mm -TimeZone "W. Europe Standard Time" -Language it-IT -LocalizeDefaultFolderName:$true
#Nel caso si voglia cambiare la lingua ad una singola casella
Set-MailboxRegionalConfiguration -Identity mail@dominio.it -DateFormat dd/MM/yyyy -TimeFormat HH:mm -TimeZone "W. Europe Standard Time" -Language it-IT -LocalizeDefaultFolderName:$true
Set-MailboxRegionalConfiguration -Identity mail@dominio.it -LocalizeDefaultFolderName:$true -Language it-IT
#Verifica localizzazioni
Get-Mailbox | Get-MailboxRegionalConfiguration

#Restore utente eliminato di un dominio che non è più presente nel tenant
Restore-MsolUser -UserPrincipalName "nome.cognome@dominio.it" -NewUserPrincipalName "nome.cognome@dominio.onmicrosoft.com" -AutoReconcileProxyConflicts


#Abilitare inoltro esterno
Set-HostedOutboundSpamFilterPolicy -Identity Default -AutoForwardingMode On
Enable-OrganizationCustomization

#Ottenere spazio occupato totale script
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics |
>> Select-Object -Property @{label="User";expression={$_.DisplayName}},
>> @{label="Total Messages";expression= {$_.ItemCount}},
>> @{label="Total Size (GB)";expression={[math]::Round(`
>> ($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1GB),2)}} |
>> Sort "Total Size (GB)" -Descending | Export-CSV -Path "C:\export.csv"

#Gestione permessi calendario
#UPS è chi deve condividere il calendario e i gruppi sono a chi lo condivide
$UPN="nome.cognome@dominio.com"
Add-MailboxFolderPermission $UPN":\calendario" –User gruppo@dominio.com –AccessRights Reviewer
Add-MailboxFolderPermission $UPN":\calendario" –User gruppo@dominio.com –AccessRights Editor
