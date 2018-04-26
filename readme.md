# Easy Docker
An easy way to maintain PHP version with some essential config like as virtual Host, Mysql, Redis and more. It's only for locahost :)

## Getting started

1. Clone the easy-docker github repository
```Bash
git clone https://github.com/rinkurock/easy-docker
```

2. Go to easy-docker directory
```Bash
cd easy-docker
```

3. Copy .env.example to .env
```Bash
cp .env.example .env
```

4. Copy docker-compose.yml.example to docker-compose.yml
```Bash
cp docker-compose.yml.example docker-compose.yml
```

5. Edit  APPLICATION=/your-root-project-directory & database setting on .env file 
```Bash
nano .env
```

6. Run docker-compose
```Bash
docker-compose up -b
```

7. Go to <http://localhost:9099> on browser


## Setup Virtual Host for porject
Run:

```Bash
sudo ./v-host.sh
```

and flow the instruction on command line

* sudo for only addning local domain address on /etc/hosts file on your system.

You can check it by run:
```Bash
cat /etc/hosts
```

Run:

```Bash
docker-compose ps
```

## Features
* Vertual Host with nginx
* PHP FPM
* PHP version 5.6, 7.0, 7.1, 7.2 etc
* MySql
* Postgres
* Adminer
* Redis
* Consul
* RabbitMq


## Contribution
All issues, PRs and advices are more than welcome to discuss about :).

## License
MIT