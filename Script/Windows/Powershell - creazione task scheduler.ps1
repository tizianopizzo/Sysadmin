#Tramite uno script powershell (eseguirlo come amministratore) è possibile creare delle operazioni pianificate all'interno dell'utilità di pianificazione
#https://www.makeuseof.com/windows-powershell-scheduled-task/

#L'esempio seguente attiva le schede di rete più volte al giorno

$action1 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet" enabled'

$action2 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 1" enabled'

$action3 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 2" enabled'

$action4 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 3" enabled'

$action5 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Wi-Fi" enabled'

$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest

$trigger1 = New-ScheduledTaskTrigger -Daily -At 08:30

$trigger2 = New-ScheduledTaskTrigger -Daily -At 11:00

$trigger3 = New-ScheduledTaskTrigger -Daily -At 13:30

$trigger4 = New-ScheduledTaskTrigger -Daily -At 16:00

Register-ScheduledTask -Action $action1,$action2,$action3,$action4,$action5 -Trigger $trigger1,$trigger2,$trigger3,$trigger4 -TaskName "Abilita scheda di rete" -Principal $principal