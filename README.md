# Battle Arena

Multiplayer Online Battle Arena in it's pure form. Written with Godot 4.

## How to setup project locally

##### MacOS/Linux
```
git submodule update --init
ln -s ../../nakama-godot/addons/com.heroiclabs.nakama battle-arena/addons/nakama
ln -s ../../gd-unit/addons/gdUnit4 battle-arena/addons/gdUnit4
ln -s ../../beehave/addons/beehave battle-arena/addons/beehave
```

##### Windows
```
git submodule update --init
mklink /d ../../nakama-godot/addons/com.heroiclabs.nakama battle-arena/addons/nakama
mklink /d ../../gd-unit/addons/gdUnit4 battle-arena/addons/gdUnit4
mklink /d ../../beehave/addons/beehave battle-arena/addons/beehave
```

## How to setup server locally

1. Install Docker and docker-compose
2. Go to *server* folder
3. run `docker compose up`

