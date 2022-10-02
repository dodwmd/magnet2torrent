#!/usr/bin/env bash

[[ ! `docker images | grep dodwmd/aria2c` ]] && docker build -t dodwmd/aria2c:latest .

DIRECTORY=/volume1/volume1/Downloads/blackhole

[[ ! -d ${DIRECTORY}}/.cache/aria2c]] && mkdir -p ${DIRECTORY}}/.cache/aria2c

if pidof -x $(basename $0) > /dev/null; then
  for p in $(pidof -x $(basename $0)); do
    if [ $p -ne $$ ]; then
      echo "Script $0 is already running: exiting"
      exit
    fi
  done
fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for f in ${DIRECTORY}/*.magnet; do
  echo "converting $f"
  docker run -u $(id -u):$(id -g) -v ${DIRECTORY}:/torrents -v ${DIRECTORY}/.cache/aria2c:/.cache/aria2c--rm -ti dodwmd/aria2c:latest /usr/bin/aria2c -d /torrents --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881 --enable-dht --dht-listen-port=6881 --enable-dht6=false $(cat "$f")
  echo "deleting $f"
  rm -f "$f"
done

IFS=$SAVEIFS
