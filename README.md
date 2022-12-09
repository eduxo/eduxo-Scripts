# scripts

### backup.sh
Tento skript vytvoří zálohu uživatelova domovského adresáře a uloží ji do ~/backups. Skript také vytvoří adresář ~/backups, pokud ještě neexistuje.

### rename_files.sh
Tento skript projde všechny soubory ve stávajícím adresáři a přidá k jejich názvům aktuální datum ve formátu YYYY-MM-DD. Například soubor image.jpg by se změnil na image_2022-12-09.jpg.

### send_net_set.py
Tento skript používá moduly netifaces a smtplib k získání informací o síťové kartě a odeslání emailové zprávy. 
