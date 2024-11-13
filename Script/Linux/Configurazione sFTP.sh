# Creare l'utente senza shell e senza cartella home, sostituire <sftpuser> col nome dell'utente
useradd -s /sbin/nologin -M <sftpuser>

# Cambiare la sua password
passwd <sftpuser>

# Creare la cartella per il servizio sFTP
mkdir -p /var/sftp/rootfs

# Cambiare i permessi nel modo che l'utente non può uscire della cartella
chown root:root /var/sftp

# Cambiare i permessi che l'utente può cmq creare dei file nella sua cartella
chmod 755 /var/sftp

# Dare l'accesso completo all'utente, ma solo per la sua cartella, se c'è anche il tomcat va messo il gruppo del tomcat
chown <sftpuser>:<sftpuser> /var/sftp/rootfs

# configurare il servizio openSSH-server per accettare le connessioni per l'sFTP
nano /etc/ssh/sshd_config

# aggiungere il blocco per l'utente
Match User <sftpuser>
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory /var/sftp
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no

# facoltativo: se si usano le chiavi per l'autenticazione, la chiave pubblica va aggiunta nel file authorized_keys
AuthorizedKeysFile      /var/sftp/.ssh/authorized_keys

# per abilitare il logging (/var/log/messages), cercare la riga
Subsystem       sftp    /usr/libexec/openssh/sftp-server
# e farla diventare
Subsystem       sftp    /usr/libexec/openssh/sftp-server -l INFO
# e in + aggiungere
Subsystem       internal-sftp    -f AUTH -l VERBOSE

# riavviare ssh
systemctl restart sshd

# aggiungere permessi del gruppo dell'utente all'sFTP
chmod -R g+rwx /var/sftp/rootfs