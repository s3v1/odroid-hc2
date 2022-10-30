# Run a minecraft server

This is a way to run a minecraft server using docker. You can start by running it interactively so you can test it and set an op, since normal docker compose will not give you console access.

The server will run in the 'server' folder. You are supposed to set up this folder yourself, this docker system is just for running the server. So you'll need to set the eula and modify the server properties

## Use docker compose to run in the foreground, with interactive console

    docker compose run minecraft

## Use docker compose to run in the background

    docker compose up -d

## Fabric server

Visit <https://fabricmc.net/use/server/> to find new urls get the fabric server. For example:

    curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.18.2/0.14.8/0.11.0/server/jar

## Mods

Check out Modrinth for a nice mod directory with search/filter capability. For example:

<https://modrinth.com/mods?g=categories%3A%27fabric%27&v=1.18.2&e=server>

The mods go in the ... mods folder ;)

It's important to remember to download the fabric API mod and put it in the mods folder. Other wise the fabric mods will not run. It's not enough to have the fabric loader
