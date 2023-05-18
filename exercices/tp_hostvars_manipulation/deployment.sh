#!/bin/bash

### My Color ###
Black='\033[0;30m'     
DarkGray='\033[1;30m'
RED='\033[0;31m'     
LightRed='\033[1;31m'
Green='\033[0;32m'     LightGreen='\033[1;32m'
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37
NC='\033[0m' # No Color

### FUNCTIONS ###
CONTAINER_USER=$USER
NETWORK_NAME=network

set -eo pipefail

info() {
    echo "
            options :
                --create <number> : create container and add the number of containers
                --infos-container : information (ip and name)
                --start : start all containers created by this script
                --stop : same to stop all containers
                --delete : same for drop all containers
                --ansible : create an inventory structure with ip
        "
}

## function create container in differente networks

create() {
    nombre_container=$1
    nombre_container_per_network=2
    id_user=1

    total_network=`expr $nombre_container / 2`
    
    id_already=`docker ps -a --format '{{ .Names }}' | awk -v user="${CONTAINER_USER}" '$1 ~ "^"user {count++} END {print count}'`

    id_min=$((id_already + 1))

    for i in $(seq $id_min $total_network); do
        echo -e "${RED} Create network-$i ${NC}"
           docker network create network-$i
                echo "Create Container ..."
                    for (( c=1; c<3; c++ )); do 
                        docker run -d --name ${CONTAINER_USER}-$id_user --hostname nodes-$id_user --network network-$i smarlino/ubuntu-cible:1.1
                        ((id_user++))
                    done
    done

    infosContainers
    exit 0
}

infosContainers(){
	echo "#####"
        echo -e "${Green} Informations des conteneurs actif: ${NC}"
            echo -e "${DarkGray}#####${NC}"
                 
                    docker inspect --format 'Name: {{.Name}} -- IP: {{range .NetworkSettings.Networks }}{{.IPAddress}}{{end}}' $(docker ps -q) | sed "s/[/]//"
                
            echo -e "${DarkGray}#####${NC}"
  exit 0
}

ansible() {

    ## Create directory
    mkdir -p group_vars
    mkdir -p host_vars

    ## Create File
    touch 00_inventory.ini
    touch group_vars/all.yml

    count_already=`docker network ls | awk -v network="${NETWORK_NAME}" '$2 ~ "^"network {count++} END {print count}'`

    for (( c=1; c<=$count_already; c++ )); do 
        content=`docker network inspect -f '{{json .Containers}}' ${NETWORK_NAME}-$c | jq '.[] | .Name '`

        touch group_vars/groupe$c.yml
        echo -e "network: ${NETWORK_NAME}-$c" >> group_vars/groupe$c.yml

        ### Format group_vars file
        echo -e "[groupe$c]\n$content\n" >> 00_inventory.ini

        sed -i "s/\"//" 00_inventory.ini
        sed -i "s/\"//" 00_inventory.ini

    done

    count=`docker inspect --format 'Name: {{.Name}} --IP: {{range .NetworkSettings.Networks }}{{.IPAddress}}{{end}}' $(docker ps -q) | wc -l`
    
    for ((i=1; i<=$count; i++)); do

        host=`docker inspect --format '{{range .NetworkSettings.Networks }}{{.IPAddress}}{{end}}' ${CONTAINER_USER}-$i`
        touch host_vars/${CONTAINER_USER}-$i.yml

        ## Format host_vars file
        echo -e "ansible_host: $host" >> host_vars/${CONTAINER_USER}-$i.yml
    done

    if [ -f "group_vars/all.yml" ]; then
	    echo -e "ansible_user: $USER \nansible_ssh_private_key_file: $PWD/" >> group_vars/all.yml
    fi

}
# On démarre ici !!! ###################################################################""

#si option --create
if [ "$1" == "--create" ];then
	create $2 $3

# si option --drop
elif [ "$1" == "--drop" ];then
	delete $2

# si option --start
elif [ "$1" == "--start" ];then
	start $2

# si option --ansible
elif [ "$1" == "--ansible" ];then
	ansible

# si option --infos
elif [ "$1" == "--infos-container" ];then
	infosContainers

# si aucune option affichage de l'aide
else
	info
fi