# Run a minecraft server

This is a way to run a minecraft server using docker. You can start by running it interactively so you can test it and set an op, since normal docker compose will not give you console access.

The server will run in the 'server' folder. You are supposed to set up this folder yourself, this docker system is just for running the server. So you'll need to set the eula and modify the server properties

## Use docker compose to run in the foreground, with interactive console
To test it out and make sure you're settings are in order, you should run it in the foreground to start with:

    docker compose run minecraft

## Use docker compose to run in the background
Once, you've verified that all is good, you can use this command instead:

    docker compose up -d

## Fabric server

Visit <https://fabricmc.net/use/server/> to find new urls get the fabric server. For example:

    curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.18.2/0.14.8/0.11.0/server/jar

## Mods

Check out Modrinth for a nice mod directory with search/filter capability. For example:

<https://modrinth.com/mods?g=categories%3A%27fabric%27&v=1.18.2&e=server>

The mods go in the ... mods folder ;)

It's important to remember to download the fabric API mod and put it in the mods folder. Other wise the fabric mods will not run. It's not enough to have the fabric loader

Article about performance server mods for fabric: <https://shockbyte.com/billing/knowledgebase/214/How-to-Reduce-Lag-on-a-FabricMC-Server.html>

## Performance

The Odroid HC2 run a small minecraft server OK. Not great, but OK for family & friends level. You probably need some fabric server performance mods or an performance focused alternative like papermc. I opted for fabric, since I like the vanilla compatibility. I have tested papermc nad it ran with similar performance, maybe a tad faster.

I'm using an SSD and disk speed does not seem to be an issue. I've been watching iowait in top and it's almost always 0. I have not tried it with a normal hdd, but I expect it will be fine too, if you can live with some small hiccups when generating chunks or other disk work.

CPU average usage looks low until you look at individual cores. Usually a core or two is at 100%, when running a game, with just one player. TPS is close to 20, but server sometime shows small signs of lag. An SBC like the raspberry PI 4 has better single-core performance, I expect it would run smoother. However, we must work with the tools we're given.

A quick way to get more TPS is to change the radius for simulating the world. That'll give the server less work, so it can better keep up:
Default in server.properties is:

    simulation-distance=10

That's 10 x 10 = 100 blocks centered around each player.

You can set that a bit lower to see TPS improvements

    simulation-distance=7

That's 7 x 7 = 49 blocks centered around each player. Since that's around half the blocks, it should improve TPS quite a bit.
I used spark to profile with one player running around, and could get 20 TPS consistenly with an MSPT around 50

<https://spark.lucko.me/AIczkzdpzQ>

However, I still get messages like this in the log, so it's not perfect: " [Server thread/WARN]: Can't keep up! Is the server overloaded? Running 2836ms or 56 ticks behind". But it's pretty rare.

Read more about spark options here: <https://spark.lucko.me/docs/Command-Usage>

## RCON

RCON is a way to use a cli to issue remote commands to a server that you don't have a console connection to. We can use a docker image made by itzg <https://hub.docker.com/r/itzg/rcon-cli/tags>:

    docker run --rm itzg/rcon-cli --password rcon
