extends Node3D


var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)


func _ready() -> void:
    var peer: = ENetMultiplayerPeer.new()
    peer.create_server(port)
    multiplayer.multiplayer_peer = peer
    
    var params: = {
        "id" = multiplayer.get_unique_id(),
        "character" = 1
    }
    
    var character = %TeamA.spawn(params)
    %TeamA.on_spawned(character)
