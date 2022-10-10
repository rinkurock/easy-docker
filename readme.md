# Easy Docker
An easy way to maintain PHP version with some essential config like as virtual Host, Mysql, Redis and more. It's only for localhost :)

## Getting started

1. Clone the easy-docker github repository
```Bash
git clone https://github.com/rinkurock/easy-docker ~/easy-docker
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
docker-compose up -d
```

7. Go to <http://localhost:9999> on browser


## Setup Virtual Host for porject
Run:

```Bash
sudo ./v-host.sh
```

and follow the instructions on command line

* sudo for only addning local domain address on /etc/hosts file on your system.

You can check it by run:
```Bash
cat /etc/hosts
```

Run:

```Bash
docker-compose ps
```
#### Accessing Globally
Sometimes you may want to `docker-compose` up your `easy-docker` machine from anywhere on your filesystem. You can do this on Unix systems by adding a Bash function to your Bash profile. These scripts will allow you to run any `docker-compose` command from anywhere on your system and will automatically point that command to your `easy-docker` installation:

```
function easydocker() {
    ( cd ~/easy-docker && docker-compose $* )
}
```

## Features
* Vertual Host with nginx
* PHP FPM
* PHP version 5.5.34, 5.6, 7.0, 7.1, 7.1.3, 7.2, 7.3.22, 7.4.13, 8.1.0 etc
* MySql 5.7, 8.0.19
* Postgres
* Adminer
* Redis
* Mongo
* Consul
* RabbitMq
* Elastic Search
* Kibana

## Contribution
All issues, PRs and advices are more than welcome to discuss about :).

## License
MIT
