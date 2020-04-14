
UPDATE mysql.db SET Host='%' WHERE Host='localhost' AND User='root';
FLUSH PRIVILEGES ;