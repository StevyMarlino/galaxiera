#!/bin/bash
echo "veuillez entrer les noms des containeurs:"

read container

RESULT=`docker inspect --format '{{range .NetworkSettings.Networks }}{{.IPAddress}}{{end}}' $container`

echo "voulez vous rediriger la sortie vers un fichier ? [Y/N]"
read response 

if [ $response != "Y" ]; then 
    echo "veuillez le nom du groupe" 
    read group 
	echo -e "[$group]\n$RESULT \n" && exit -1   
fi
