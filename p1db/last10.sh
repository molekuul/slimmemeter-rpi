set -v
mysql -e  "(select * from P1uitlezen order by ID desc limit 10) order by ID asc;" p1db
