#
# DSMR 2.2 P1 uitlezer
# (c) 10-2012 - GJ - gratis te kopieren en te plakken
# (c) 12-2015 / 2016 - GJ Database versie

versie = "2.1"
import sys
import serial
import time
import MySQLdb as mdb

################
#Error display #
################
def show_error():
    ft = sys.exc_info()[0]
    fv = sys.exc_info()[1]
    print("Fout type: %s" % ft )
    print("Fout waarde: %s" % fv )
    return

###########################################################
# Values voor de database                                 #
###########################################################
#mysql> desc p1db.P1uitlezen;
#+-----------------------+---------+------+-----+---------+----------------+
#| Field                 | Type    | Null | Key | Default | Extra          |
#+-----------------------+---------+------+-----+---------+----------------+
#| ID                    | int(11) | NO   | PRI | NULL    | auto_increment |
#| date                  | date    | NO   |     | NULL    |                |
#| time                  | time    | NO   |     | NULL    |                |
#| timestamp             | int(11) | YES  |     | NULL    |                |
#| T1afgenomen           | int(11) | NO   |     | NULL    |                |
#| T2afgenomen           | int(11) | NO   |     | NULL    |                |
#| T1terug               | int(11) | NO   |     | NULL    |                |
#| T2terug               | int(11) | NO   |     | NULL    |                |
#| Tarief                | int(11) | NO   |     | NULL    |                |
#| Afgenomenvermogen     | int(11) | NO   |     | NULL    |                |
#| Teruggeleverdvermogen | int(11) | NO   |     | NULL    |                |
#| Totaalvermogen        | int(11) | NO   |     | NULL    |                |
#| Gas                   | int(11) | NO   |     | NULL    |                |
#+-----------------------+---------+------+-----+---------+----------------+
#13 rows in set (0.02 sec)


# Login 	p1db_user
# password	p1db_password
# database	p1db
# Tabel		P1uitlezen

###########################################################
#function for storing readings into MySql                 #
###########################################################
def insertDB(T1afgenomen, T2afgenomen, T1terug, T2terug, Tarief, Afgenomenvermogen, Teruggeleverdvermogen, Totaalvermogen, Gas):

  try:
    con = mdb.connect('localhost', 'p1db_user', 'p1db_password', 'p1db');
    cursor = con.cursor()

    sql = "INSERT INTO P1uitlezen(date, time, timestamp, T1afgenomen, T2afgenomen, T1terug, T2terug, Tarief, Afgenomenvermogen, Teruggeleverdvermogen, Totaalvermogen, Gas) \
    VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % \
    (time.strftime("%Y-%m-%d"), time.strftime("%H:%M"), timestamp, T1afgenomen, T2afgenomen, T1terug, T2terug, Tarief, Afgenomenvermogen, Teruggeleverdvermogen, Totaalvermogen, Gas)
    cursor.execute(sql)
    sql = []
    con.commit()
    con.close()

  except mdb.Error, e:
     print e

###########################################################
#function for printing Values                             #
###########################################################
def printValues(T1afgenomen, T2afgenomen, T1terug, T2terug, Tarief, Afgenomenvermogen, Teruggeleverdvermogen, Totaalvermogen, Gas):
  print "daldag      ", T1afgenomen
  print "piekdag     ", T2afgenomen
#	print "meter totaal  ", meter
  print "dalterug    ", T1terug
#	print "meter totaal  ", meter
  print "piekterug   ", T2terug
  print "meter totaal ", meter, " (afgenomen/teruggeleverd van het net vanaf 17-10-2014)"
  print "Afgenomen vermogen      ", Afgenomenvermogen, " W"
  print "Teruggeleverd vermogen  ", Teruggeleverdvermogen, " W"
  print "Totaal vermogen         ", Totaalvermogen, " W"
  print "Tarief (1=hoog 2=laag)  ", Tarief
  print "Gas                     ", Gas, " dm3"


################################################################################################################################################
#Main program
################################################################################################################################################
print ("DSMR P1 uitlezer",  versie)
print ("Gemiddelde telegram uitlezen duurt 10 seconden")
print ("Control-C om te stoppen")

#Set COM port config
ser = serial.Serial()
ser.baudrate = 9600
ser.bytesize=serial.SEVENBITS
ser.parity=serial.PARITY_EVEN
ser.stopbits=serial.STOPBITS_ONE
ser.xonxoff=0
ser.rtscts=0
ser.timeout=20
ser.port="/dev/ttyUSB0"

#Open COM port
try:
    ser.open()
except:
    sys.exit ("Fout bij het openen van %s. Programma afgebroken."  % ser.name)      

#genereer timestamp afgerond op min
timestamp = int(time.time()/100)*100


#Initialize
# stack is mijn list met de 20 regeltjes.
p1_teller=0
stack=[]
T1afgenomen = 0
T1terug = 0
T2afgenomen = 0
T2terug = 0
Tarief = 0
Gas = 0
Afgenomenvermogen = 0
Teruggeleverdvermogen = 0
Totaalvermogen = 0

while p1_teller < 20:
    p1_line=''
#Read 1 line
    try:
        p1_raw = ser.readline()
    except:
        sys.exit ("Seriele poort %s kan niet gelezen worden. Programma afgebroken." % ser.name )      
    p1_str=str(p1_raw)
    #p1_str=str(p1_raw, "utf-8")
    p1_line=p1_str.strip()
    stack.append(p1_line)
# als je alles wil zien moet je de volgende line uncommenten
#    print (p1_line)
    p1_teller = p1_teller +1

#Initialize
# stack_teller is mijn tellertje voor de 20 weer door te lopen. Waarschijnlijk mag ik die p1_teller ook gebruiken
stack_teller=0
meter=0

while stack_teller < 20:
   if stack[stack_teller][0:9] == "1-0:1.8.1":
	T1afgenomen = int(stack[stack_teller][10:15])
# 	Alleen voor debug
#	print "daldag      ", T1afgenomen
	meter = meter +  int(float(stack[stack_teller][10:15]))
   elif stack[stack_teller][0:9] == "1-0:1.8.2":
	T2afgenomen = int(stack[stack_teller][10:15])
# 	Alleen voor debug
#	print "piekdag     ", T2afgenomen
	meter = meter + int(float(stack[stack_teller][10:15]))
# 	Alleen voor debug
#	print "meter totaal  ", meter
# Daltarief, teruggeleverd vermogen 1-0:2.8.1
   elif stack[stack_teller][0:9] == "1-0:2.8.1":
	T1terug = int(stack[stack_teller][10:15])
# 	Alleen voor debug
#	print "dalterug    ", T1terug
	meter = meter - int(float(stack[stack_teller][10:15]))
# 	Alleen voor debug
#	print "meter totaal  ", meter
# Piek tarief, teruggeleverd vermogen 1-0:2.8.2
   elif stack[stack_teller][0:9] == "1-0:2.8.2":
	T2terug = int(stack[stack_teller][10:15])
# 	Alleen voor debug
#        print "piekterug   ", T2terug
        meter = meter - int(float(stack[stack_teller][10:15]))
# mijn verbruik was op 17-10-2014 1751 kWh teveel teruggeleverd. Nieuw jaar dus opnieuw gaan rekenen
	meter = meter + 1751
# 	Alleen voor debug
#        print "meter totaal ", meter, " (afgenomen/teruggeleverd van het net vanaf 17-10-2014)"
# Huidige stroomafname: 1-0:1.7.0
   elif stack[stack_teller][0:9] == "1-0:1.7.0":
	Afgenomenvermogen = int(float(stack[stack_teller][10:17])*1000)
# 	Alleen voor debug
#        print "Afgenomen vermogen      ", Afgenomenvermogen, " W"
# Huidig teruggeleverd vermogen: 1-0:1.7.0
   elif stack[stack_teller][0:9] == "1-0:2.7.0":
	Teruggeleverdvermogen = int(float(stack[stack_teller][10:17])*1000)
# 	Alleen voor debug
#        print "Teruggeleverd vermogen  ", Teruggeleverdvermogen, " W"
	Totaalvermogen = Afgenomenvermogen - Teruggeleverdvermogen
# 	Alleen voor debug
#	print "Totaal vermogen         ", Totaalvermogen, " W"
# Tarief (0-0:96.14.0(0001) 1 = daltarief)
   elif stack[stack_teller][0:9] == "0-0:96.14":
	Tarief = int(stack[stack_teller][12:16])
#	print "Tarief (1=hoog 2=laag)  ", Tarief
# Gasmeter: 0-1:24.3.0
   elif stack[stack_teller][0:10] == "0-1:24.3.0":
	Gas = int(float(stack[stack_teller+1][1:10])*1000)
#        print "Gas                     ", Gas, " dm3"
   else:
	pass
   stack_teller = stack_teller +1

#print (stack, "\n")
    
#Close port and show status
try:
    ser.close()
except:
    sys.exit ("Oops %s. Programma afgebroken." % ser.name )      

# Database vullen
# print "database vullen"
if (Gas>0):
#######################################################################################################################################
# 	Alleen voor debug
#  printValues(T1afgenomen, T2afgenomen, T1terug, T2terug, Tarief, Afgenomenvermogen, Teruggeleverdvermogen, Totaalvermogen, Gas)
#######################################################################################################################################
  insertDB(T1afgenomen, T2afgenomen, T1terug, T2terug, Tarief, Afgenomenvermogen, Teruggeleverdvermogen, Totaalvermogen, Gas)
  print ("Database gevuld")

