#!/bin/bash

docker compose up --build -d

if [$? -eq 0]; then
  docker inspect --format='{{range .NetworkSettings.Networks}}{{println .IPAddress}}{{end}}' $(docker ps -q) > inventory.ini
  if [$? -eq 0]; then
    sed -i ''
  else
    echo "Error during the execution 2"  
else
    echo "Error during the execution 1"
fi