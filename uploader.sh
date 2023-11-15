windows() {
  butler push builds/windows bliznyuknm/battle-arena:windows --userversion-file=version.txt
}

linux() {
  butler push builds/linux bliznyuknm/battle-arena:linux --userversion-file=version.txt
}

macos() {
  butler push builds/macos bliznyuknm/battle-arena:osx-universal --userversion-file=version.txt
}

all () {
  windows
  linux
  macos
}

"$@"
