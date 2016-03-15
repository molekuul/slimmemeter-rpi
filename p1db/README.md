# P1db work in progress

hoe de slimme meter uit te lezen en in de database te vullen.

Gebaseerd op een standaard dabase zoals hier beschreven

Maak de datbase met create_db.sh en gebruik natuurlijk wel je eigen wachtwoorden.


Gegevens uitlezen en vullen met p1uitlezerdb.py

sciptjes zijn gebaseerd op het feit dat de user een .my.cnf in de homedir heeft met de volgende info:

[client]
user=root
password=Supermoelijkwachtwoord123
[mysqldump]
user=root
password=Supermoelijkwachtwoord123


elke twee minuten uitvoeren via de crontab

*/2 * * * *	/usr/bin/python /home/gej/p1db/p1uitlezerdb.py

