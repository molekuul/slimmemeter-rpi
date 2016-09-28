#Quick en dirty de gegevens via een php website zichtbaar maken.

##install php

```
	gej@rpi-backup:~/slimmemeter-rpi/html $ sudo apt --assume-yes install apache2 php5 php-pear
	...
```

##copieer php naar de webserver

pas het pad aan naar het juiste python script

##Testen.....

oops
de www-data user heeft niet genoeg rechten. Even de gebruiker toevoegen aan de juiste groep.

==> /var/log/apache2/error.log <==
Fout bij het openen van /dev/ttyUSB0. Programma afgebroken.

De webserver draait onder www-data.

```
	gej@rpi-backup:~/slimmemeter-rpi/html $ ps -ef | grep apache
	root      5047     1  0 15:23 ?        00:00:01 /usr/sbin/apache2 -k start
	www-data  5050  5047  0 15:23 ?        00:00:00 /usr/sbin/apache2 -k start
	...
	gej@rpi-backup:~/slimmemeter-rpi/html $ 
```

owner van /dev/ttyUSB0 is dus:

```
	gej@rpi-backup:~/slimmemeter-rpi/html $ ls -l /dev/ttyUSB0 
	crw-rw---- 1 root dialout 188, 0 Sep 18 21:13 /dev/ttyUSB0
	gej@rpi-backup:~/slimmemeter-rpi/html $
```

group uitbreiden: de group dialout krijgt een extra gebruiker, die waaronder de webserver draait.
(niet de primairy group aanpassen)

```
	gej@rpi-backup:~/slimmemeter-rpi/html $ sudo usermod -a -G dialout www-data
	gej@rpi-backup:~/slimmemeter-rpi/html $ grep www-data /etc/group
	dialout:x:20:pi,gej,www-data
	www-data:x:33:
	gej@rpi-backup:~/slimmemeter-rpi/html $ 
```

