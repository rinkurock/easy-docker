FROM mysql:8.0.19

MAINTAINER RINKU <rinku.arnob@gmail.com>

RUN chown -R mysql:root /var/lib/mysql/

ADD conf.d/my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306 33060

