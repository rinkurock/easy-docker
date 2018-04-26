#! /bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;36m'
GREEN='\033[0m' # No Color
BOLD='\033[1m'
END='\e[0m'
pprint(){
  printf "\n${GREEN}${BOLD}$1${END}\n"
}

wprint(){
  printf "\n${BLUE}${BOLD}$1${END}\n"
}

eprint(){
  printf "\n${RED}${BOLD}$1${END}\n"
}


#pprint pprint

#wprint wprint

#eprint eprint

createVirtualHost(){
  wprint "Coping  example file  to $url.conf"
  cp config/ngnix/template/example.dev.conf config/ngnix/sites/$url.conf

  cd  config/ngnix/sites
  wprint 'Replacing server_name'
  sed -i -e "s,--url--,$url,g" $url.conf

  wprint 'Replacing server root'
  sed -i -e "s,--directory--,$directory,g" $url.conf
  rm $url.conf-e
  askCopyConfigToDockerNginx

}
copyConfigToDockerNginx(){
	parent_path=$( cd ../../.. "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
    wprint "$parent_path"
	for entry in "$search_dir"$parent_path/config/ngnix/sites/*
	do
	    #echo "$search_dir"
  	    wprint "$entry"
        cp "$entry" $parent_path/docker/nginx/sites
	done

	wprint 'Copied successfully!'
  docker restart docker_nginx_1

  wprint 'NGNIX Restarted!'

  sudo echo "127.0.0.1       $url" >> /etc/hosts

  wprint 'Changed Hosts files!'

  wprint 'Done :)  Enjoy :)'


}
askCopyConfigToDockerNginx(){
  wprint "Do you want to copy ngnix virtual host file (y/n)?"
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    copyConfigToDockerNginx
  else
    echo No
    exit
  fi
}




callConfigaration(){

  pprint "path into ~/your-project-path directory as(/var/www/your-project-path)?"
  read directory

  wprint "PS: chrome does not support .dev domain any more !"
  echo web url\(example.local \) ?
  read url

  wprint "Path: $directory"
  wprint "Url url: $url"


  pprint "Are you want to continue (y/n)?"
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    createVirtualHost
  else
    eprint exit
    exit
  fi
}

pprint "Do you want to new ngnix virtual host file?" \n
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    callConfigaration
  else
  eprint No

fi
