#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ -d "server" ]; then
    echo 'Skipping server preparation, server folder already exists'
else
    ##set config
    cp -a defaults/ server

    ## get server
    wget -nc --content-disposition -P server https://meta.fabricmc.net/v2/versions/loader/1.18.2/0.14.10/0.11.1/server/jar

    ## get performance mods
    wget -nc -P server/mods https://cdn.modrinth.com/data/P7dR8mSH/versions/gjysTPsx/fabric-api-0.59.1%2B1.18.2.jar
    wget -nc -P server/mods https://cdn.modrinth.com/data/gvQqBUqZ/versions/mc1.18.2-0.7.10/lithium-fabric-mc1.18.2-0.7.10.jar
    wget -nc -P server/mods https://cdn.modrinth.com/data/hEOCdOgW/versions/mc1.18.x-0.8.1/phosphor-fabric-mc1.18.x-0.8.1.jar
    wget -nc -P server/mods https://cdn.modrinth.com/data/hvFnDODi/versions/0.1.2/lazydfu-0.1.2.jar
    wget -nc -P server/mods https://cdn.modrinth.com/data/uXXizFIs/versions/4.2.1/ferritecore-4.2.1-fabric.jar

    # get QoL mods
    wget -nc -P server/mods https://cdn.modrinth.com/data/fALzjamp/versions/1.2.164/Chunky-1.2.164.jar
    wget -nc -P server/mods https://cdn.modrinth.com/data/nEKRNLz9/versions/1.6/servertick-mc1.18-1.6.jar
    wget -nc -P server/mods https://cdn.modrinth.com/data/IIpWIe1o/versions/1XQUjVSl/leaves-us-in-peace-1.0.11%2BMC1.18.2.jar
fi

cd server
#docker run -v "$PWD:/wrk" -w "/wrk" -it --rm -p 25565:25565 --name minecraft eclipse-temurin:17 java -Xmx1g -XX:+UseG1GC -jar fabric-server-mc*.jar nogui
java -Xmx1g -XX:+UseG1GC -jar fabric-server-mc*.jar nogui
