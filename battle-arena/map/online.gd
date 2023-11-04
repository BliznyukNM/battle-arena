extends Node3D


var selected_hero: int


func _ready() -> void:
    multiplayer.multiplayer_peer = Matchmaking.multiplayer.multiplayer_peer
