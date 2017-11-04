CREATE USER 'p1db_user@'localhost' IDENTIFIED BY 'p1db_password';




CREATE USER 'p1db_web'@'localhost' IDENTIFIED BY 'Website123';
GRANT ALL PRIVILEGES ON p1db.* TO 'p1db_web'@'localhost';
FLUSH PRIVILEGES;




SELECT User, Host, Password FROM mysql.user;
