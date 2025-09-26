#Eseguirlo con taskschd.msc con il seguente argomento: 
#-ExecutionPolicy Bypass -File "C:\Script\SvuotaDownloadCestino.ps1"

# Percorso cartella Download dell'utente corrente
$downloadPath = [Environment]::GetFolderPath("UserProfile") + "\Downloads"

# Elimina tutti i file
Get-ChildItem -Path $downloadPath -File -Force | Remove-Item -Force -ErrorAction SilentlyContinue

# Elimina tutte le sottocartelle
Get-ChildItem -Path $downloadPath -Directory -Force | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# Svuota il cestino
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Output "Download e Cestino svuotati correttamente."
