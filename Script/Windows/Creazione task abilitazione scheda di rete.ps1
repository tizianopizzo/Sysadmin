{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 $action1 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet" enabled'\
\
$action2 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 1" enabled'\
\
$action3 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 2" enabled'\
\
$action4 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 3" enabled'\
\
$action5 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 4" enabled'\
\
$action6 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Ethernet 5" enabled'\
\
$action7 = New-ScheduledTaskAction -Execute 'netsh' -Argument 'interface set interface "Wi-Fi" enabled'\
\
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\\SYSTEM" -LogonType ServiceAccount -RunLevel Highest\
\
$trigger1 = New-ScheduledTaskTrigger -Daily -At 08:30\
\
$trigger2 = New-ScheduledTaskTrigger -Daily -At 11:00\
\
$trigger3 = New-ScheduledTaskTrigger -Daily -At 13:30\
\
$trigger4 = New-ScheduledTaskTrigger -Daily -At 16:00\
\
Register-ScheduledTask -Action $action1,$action2,$action3,$action4,$action5,$action6,$action7 -Trigger $trigger1,$trigger2,$trigger3,$trigger4 -TaskName "Abilita scheda di rete" -Principal $principal}