extends Node


@export var host: = "127.0.0.1"
@export var port: = 7350


var monk: = preload("res://characters/character_monk_a.tscn")


func start(is_server: bool) -> void:
    multiplayer.connected_to_server.connect(self._on_connected_to_server)
    multiplayer.connection_failed.connect(self._on_connection_failed)
    multiplayer.server_disconnected.connect(self._on_server_disconnected)
    multiplayer.peer_connected.connect(self._on_peer_connected)
    multiplayer.peer_disconnected.connect(self._on_peer_disconnected)
    
    var peer: = ENetMultiplayerPeer.new()
    if is_server: peer.create_server(port)
    else: peer.create_client(host, port)
    
    multiplayer.multiplayer_peer = peer


func _on_server_disconnected() -> void:
    print("Server disconnected")


func _on_connected_to_server() -> void:
    print("Connected to server!")


func _on_peer_connected(id: int) -> void:
    print("Client connected: %d" % id)
    
    if not multiplayer.is_server(): return
    
    var monk_instance: Character = monk.instantiate()
    monk_instance.name = str(id)
    monk_instance.player_id = id
    
    %Players.add_child(monk_instance)


func _on_peer_disconnected(id: int) -> void:
    print("Client disconnected: %d" % id)
    
    if not %Players.has_node(str(id)): return
    %Players.get_node(str(id)).queue_free()


func _on_connection_failed() -> void:
    print("Failed connecting to server :(")


func _exit_tree() -> void:
    multiplayer.multiplayer_peer.close()
