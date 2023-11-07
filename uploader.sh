windows() {
  butler push builds/windows bliznyuknm/battle-arena:windows
}

linux() {
  butler push builds/linux bliznyuknm/battle-arena:linux
}

macos() {
  butler push builds/macos bliznyuknm/battle-arena:osx-universal
}

all () {
  windows
  linux
  macos
}

"$@"
