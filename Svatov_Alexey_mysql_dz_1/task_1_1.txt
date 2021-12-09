#1
   89  sudo dnf install https://repo.mysql.com//mysql80-community-release-fc31-1.noarch.rpm
   90  sudo dnf install mysql-community-server
   91  sudo systemctl start mysqld
   92  sudo systemctl enable mysqld
   93  sudo grep 'temporary password' /var/log/mysqld.log
   94  sudo mysql_secure_installation

