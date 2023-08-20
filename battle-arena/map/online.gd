extends Node3D


func _ready() -> void:
    multiplayer.multiplayer_peer = Matchmaking.multiplayer.multiplayer_peer
