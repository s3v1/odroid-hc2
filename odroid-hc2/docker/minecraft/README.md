
# Run a minecraft server

## Get fabric server

Visit https://fabricmc.net/use/server/ to get the fabric server. For example:

    curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.18.2/0.14.8/0.11.0/server/jar

## run standalone

    java -Xmx2G -XX:+UseG1GC -jar fabric-server-mc.1.18.2-loader.0.14.8-launcher.0.11.0.jar nogui

## Run in docker

    docker run -v "$PWD:/wrk" -w "/wrk" -it --rm eclipse-temurin:17 java -Xmx2G -XX:+UseG1GC -jar fabric-server-mc.1.18.2-loader.0.14.8-launcher.0.11.0.jar nogui
