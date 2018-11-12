#! /bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;36m'
GREEN='\033[0m' # No Color
BOLD='\033[1m'
END='\e[0m'
ROOT_PATH=$PWD

pprint() {
    printf "\n${GREEN}${BOLD}$1${END}\n"
}

wprint() {
    printf "\n${BLUE}${BOLD}$1${END}\n"
}

eprint() {
    printf "\n${RED}${BOLD}$1${END}\n"
}

createVirtualHost() {
    wprint "Coping \`example.dev file\` to \`$url.conf\`"
    cp ${ROOT_PATH}/config/ngnix/template/example.dev.conf ${ROOT_PATH}/config/ngnix/sites/${url}.conf

    cd config/ngnix/sites
    wprint 'Replacing server_name'
    sed -i -e "s,--url--,$url,g" ${url}.conf

    NEW_DIR="/var/www/"${directory}
    wprint 'Replacing server root'
    sed -i -e "s,--directory--,$NEW_DIR,g" ${url}.conf

    tmp_file="$url.conf-e"
    if [[ -f "$tmp_file" ]]; then
        rm ${tmp_file}
    fi

    cd ${ROOT_PATH}
    askCopyConfigToDockerNginx
}

copyConfigToDockerNginx() {
#	parent_path=$( cd ../../.. "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
	for entry in ${ROOT_PATH}/config/ngnix/sites/*
	do
        cp "$entry" ${ROOT_PATH}/docker/nginx/sites
	done
	wprint 'Copied successfully!'

    docker restart $(docker-compose ps -q nginx | awk '{print $1}')
    wprint 'NGINX Restarted!'

    sudo echo "127.0.0.1        $url" >> /etc/hosts
    wprint 'Changed Hosts files!'
    wprint "Go To: $url"
    wprint 'Enjoy :)'
}

askCopyConfigToDockerNginx() {
    wprint "Do you want to copy ngnix virtual host file (y/n)?"
    read answer
    if echo "$answer" | grep -iq "^y" ;then
        copyConfigToDockerNginx
    else
        echo No
        exit
    fi
}

callConfiguration() {
    pprint "Enter relative path according to .env \`APPLICATION\` config such as (your-project-directory/public)?"
    read directory

    wprint "PS: chrome does not support .dev domain any more !"
    echo web url \(example.local\)?
    read url

    wprint "Project Path: ${ROOT_PATH}/$directory"
    wprint "Url: $url"

    pprint "Are you want to continue (y/n)?"
    read answer
    if echo "$answer" | grep -iq "^y" ;then
        createVirtualHost
    else
        eprint exit
        exit
    fi
}

pprint "Do you want to new ngnix virtual host file? (y/n)"
read answer
if echo "$answer" | grep -iq "^y"; then
    callConfiguration
else
    eprint No
fi
