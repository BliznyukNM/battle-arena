#!/bin/sh
mkdir battle-arena/addons
ln -s ../../nakama-godot/addons/com.heroiclabs.nakama battle-arena/addons/nakama
ln -s ../../gd-unit/addons/gdUnit4 battle-arena/addons/gdUnit4

mkdir builds
mkdir builds/windows
mkdir builds/macos
mkdir builds/linux

cp .itch.toml builds/windows
cp .itch.toml builds/macos
cp .itch.toml builds/linux
