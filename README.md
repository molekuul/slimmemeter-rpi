# slimmemeter-rpi
zie ook

http://gejanssen.com/howto/Slimme-meter-uitlezen/index.html
en
http://gejanssen.com/howto/rpi-rrd-power/index.html

## Eerst even kijken of we serieel uit kunnen lezen

	gej@raspberrypi(gej): ~/slimmemeter-rpi $ python P1uitlezen.py 
	('DSMR P1 uitlezen', '1.0')
	Control-C om te stoppen
	Pas eventueel de waarde ser.port aan in het python script
	5210000)(00)(60)(1)(0-1:24./KMP5 KA6U001660297912

	0-0:96.1.1(204B413655303031363630323937393132)
	1-0:1.8.1(07041.882*kWh)
	1-0:1.8.2(02351.565*kWh)
	1-0:2.8.1(03125.397*kWh)
	1-0:2.8.2(07729.108*kWh)
	0-0:96.14.0(0001)
	1-0:1.7.0(0000.54*kW)
	1-0:2.7.0(0000.00*kW)
	0-0:96.13.1()
	0-0:96.13.0()
	0-1:24.1.0(3)
	0-1:96.1.0(3238313031353431303034303232323131)
	0-1:24.3.0(160315210000)(00)(60)(1)(0-1:24.2.1)(m3)
	(04083.631)
	!
	/KMP5 KA6U001660297912

	0-0:96.1.1(204B413655303031363630323937393132)
	gej@raspberrypi(gej): ~/slimmemeter-rpi $ 

## Daarna kijken of we de telegram kunnen uitlezen en verwerken

	gej@raspberrypi(gej): ~/slimmemeter-rpi $ python P1uitlezer.py 
	('DSMR P1 uitlezer', '1.0')
	Control-C om te stoppen
	daldag       07041
	piekdag      02351
	dalterug     03125
	piekterug    07729
	meter totaal  289  (afgenomen/teruggeleverd van het net vanaf 17-10-2014)
	Afgenomen vermogen       2680  W
	Teruggeleverd vermogen   0  W
	Gas                      4083631  dm3
	gej@raspberrypi(gej): ~/slimmemeter-rpi $ 

## Automagiseren met de crontab

	*/5 * * * *     /root/Script/uitlezen.sh

# 1 keer per 5 minuten, uitlezen via seriele interface van de slimme meter
	su - gej -c "python /home/gej/P1uitlezer.py > /home/gej/P1uitlezer.txt" 2>&1 >/dev/null


## fase 2 rrdpower

Als dit allemaal werkt kun je dit in automatisch uitlezen en in de rrd database zetten.
Vervolgens dan nog even de plaatjes genereren, en je hebt een grafische interpretatie van je stroomverbruik.

zie verder in rrdpower.

## Fase 3 mysql

Gebruik van een database voor de opslag van de gegevens.

zie p1db.
