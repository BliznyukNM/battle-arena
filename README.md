# Battle Arena

Multiplayer Online Battle Arena in it's pure form. Written with Godot 4.

## How to setup project locally

```
git submodule update --init
mkdir battle-arena/addons
ln -s ../../nakama-godot/addons/com.heroiclabs.nakama battle-arena/addons/nakama
ln -s ../../gd-unit/addons/gdUnit4 battle-arena/addons/gdUnit4
```

## How to setup server locally

1. Install Docker and docker-compose
2. Go to *server* folder
3. run `docker compose up`

