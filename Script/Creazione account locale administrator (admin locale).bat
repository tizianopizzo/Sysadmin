net user utentedacreare passwordnuovoutente /ADD /PASSWORDCHG:Yes /LOGONPASSWORDCHG:No /EXPIRES:never /ACTIVE:YES
net localgroup administrators Systems /add
WMIC USERACCOUNT WHERE Name='nuovoutente' SET PasswordExpires=FALSE
PAUSE