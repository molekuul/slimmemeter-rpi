# P1db work in progress

hoe de slimme meter uit te lezen en in de database te vullen.

Gebaseerd op een standaard database zoals hier beschreven
De versie van de slimme meter is belangrijk voor het script. Dus een Dutch Smart Meter 4.2 is script versie 42 (p1uitlezerdb-DSMR42.py).


Maak de database en user aan met create_db.sh en gebruik natuurlijk wel je eigen wachtwoorden.
```
$ ./create_db.sh
```

Gegevens uitlezen en vullen met p1uitlezerdb-DSMR42.py

```
$ python p1uitlezerdb-DSMR42.py
```
Sommige scriptjes moeten nog even aangepast worden.

sciptjes zijn gebaseerd op het feit dat de user een .my.cnf in de homedir heeft met de volgende info:

```
	[client]
	user=root
	password=Supermoelijkwachtwoord123
	[mysqldump]
	user=root
	password=Supermoelijkwachtwoord123
```


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
<<<<<<< HEAD
```

## Testrun
```
root@raspberrypi:/home/gej/slimmemeter-rpi/p1db# /usr/bin/python /home/gej/slimmemeter-rpi/p1db/p1uitlezerdb-DSMR22.py
('DSMR P1 uitlezer', '2.1')
Gemiddelde telegram uitlezen duurt 10 seconden
Control-C om te stoppen
(1045, "Access denied for user 'p1db_user'@'localhost' (using password: YES)")
```
Ah, de user vergeten.

```
MariaDB [(none)]> GRANT ALL PRIVILEGES ON p1db.* TO 'p1db_user'@'localhost' IDENTIFIED BY 'p1db_password';
Query OK, 0 rows affected (0.04 sec)

MariaDB [(none)]> flush privileges
    -> ;
Query OK, 0 rows affected (0.04 sec)

MariaDB [(none)]> 


## Website
installeer php rommel

```
gej@rpib2:~# sudo apt install php5-mysql
```

Kreeg rare foutmeldingen:

```
tail -f /var/log/apache2/error.log

[Wed Mar 29 11:34:05.944863 2017] [:error] [pid 25764] [client 10.1.1.2 PHP Warning:  Unknown: failed to open stream: Permission denied in Unknown on line 0
[Wed Mar 29 11:34:05.945503 2017] [:error] [pid 25764] [client 10.1.1.2 PHP Fatal error:  Unknown: Failed opening required '/var/www/html/php/who.php' (include_path='.:/usr/share/php:/usr/share/pear') in Unknown on line 0
```

execute bit moest aan.
```
gej@rpib2:~# chmod 755 *.php
=======
>>>>>>> fdcb8452de5bb5cca2a84b866326ab3a001c2c85
```

