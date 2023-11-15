#!/bin/sh
mkdir battle-arena/addons
ln -s ../../nakama-godot/addons/com.heroiclabs.nakama battle-arena/addons/com.heroiclabs.nakama
ln -s ../../Gut/addons/gut battle-arena/addons/gut

mkdir builds
mkdir builds/windows
mkdir builds/macos
mkdir builds/linux

cp .itch.toml builds/windows
cp .itch.toml builds/macos
cp .itch.toml builds/linux
