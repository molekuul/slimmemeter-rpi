# P1db work in progress

hoe de slimme meter uit te lezen en in de database te vullen.

Gebaseerd op een standaard database zoals hier beschreven
De versie van de slimme meter is belangrijk voor het script. Dus een Dutch Smart Meter 4.2 is script versie 42 (p1uitlezerdb-DSMR42.py).


Maak de datbase met create_db.sh en gebruik natuurlijk wel je eigen wachtwoorden.
```
	$ ./create_db.sh
```


Gegevens uitlezen en vullen met p1uitlezerdb-DSMR42.py

```
	$ python p1uitlezerdb-DSMR42.py
```
Sommige scriptjes moeten nog even aangepast worden.

sciptjes zijn gebaseerd op het feit dat de user een .my.cnf in de homedir heeft met de volgende info:

	[client]
	user=root
	password=Supermoelijkwachtwoord123
	[mysqldump]
	user=root
	password=Supermoelijkwachtwoord123


elke twee minuten uitvoeren via de crontab
(denk aan het pad, dat is bij iedereen anders)

```
	$ crontab -e
	*/2 * * * *     /usr/bin/python /home/gej/slimmemeter-rpi/p1db/p1uitlezerdb-DSMR42.py
```

Testrun

```
	root@rpi-backup:/home/gej/slimmemeter-rpi/p1db# python p1uitlezerdb-DSMR42.py
	Traceback (most recent call last):
	  File "p1uitlezerdb-DSMR42.py", line 10, in <module>
	    import MySQLdb as mdb
	ImportError: No module named MySQLdb
	gej@rpi-backup:/home/gej/slimmemeter-rpi/p1db# 
```

Helaas, geen mysql module binnen python, even installeren.

```
root@rpi-backup:/home/gej/slimmemeter-rpi/p1db# sudo apt install python-mysqldb
...
```
## Mysql - PHP

Install php-mysql

```
	gej@rpib2:~# sudo apt install php5-mysql
```

