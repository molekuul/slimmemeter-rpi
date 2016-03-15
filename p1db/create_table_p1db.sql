CREATE DATABASE IF NOT EXISTS p1db;
use p1db;

DROP TABLE IF EXISTS `P1uitlezen`;
#(even kijken of ik de databse kan vullen met default now())
CREATE TABLE P1uitlezen (
ID INT NOT NULL AUTO_INCREMENT,
`date` date NOT NULL,
`time` time NOT NULL,
`timestamp` int(11) DEFAULT NULL,
T1afgenomen INT NOT NULL,
T2afgenomen INT NOT NULL,
T1terug INT NOT NULL,
T2terug INT NOT NULL,
Tarief INT NOT NULL,
Afgenomenvermogen INT NOT NULL,
Teruggeleverdvermogen INT NOT NULL,
Totaalvermogen INT NOT NULL,
Gas INT NOT NULL,
PRIMARY KEY (ID)
) ENGINE = InnoDB;

GRANT ALL PRIVILEGES ON p1db.* TO 'p1db_user'@'localhost' IDENTIFIED BY 'p1db_password';
FLUSH PRIVILEGES;
