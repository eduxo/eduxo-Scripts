# Import modulů pro práci se síťovou kartou a emailem
import netifaces
import smtplib

# Nastavení emailového účtu a příjemce zprávy
sender = 'sender@example.com'
recipient = 'recipient@example.com'

# Připojení kabelu do rozhraní ethernet
if netifaces.AF_LINK in netifaces.ifaddresses('eth0'):
    # Získání informací o síťové kartě
    addr = netifaces.ifaddresses('eth0')[netifaces.AF_LINK][0]
    mac = addr['addr']
    netmask = addr['netmask']
    broadcast = addr['broadcast']

    # Připojení k emailovému serveru a odeslání zprávy
    server = smtplib.SMTP('smtp.example.com')
    server.login('sender@example.com', 'password')
    message = 'Mac: %s\nNetmask: %s\nBroadcast: %s\n' % (mac, netmask, broadcast)
    server.sendmail(sender, recipient, message)
    server.quit()
