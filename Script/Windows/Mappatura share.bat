REM se si vuole disconnettere una share
REM net use Z: /delete
REM se si vogliono disconnettere tutte le share
REM net use * /delete

net use Z: \\192.168.1.100\Share /user:nome.cognome password /persistent:yes
