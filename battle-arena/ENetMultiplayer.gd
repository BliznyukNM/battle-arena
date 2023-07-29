extends Node


var host: String:
    get: return ProjectSettings.get_setting("application/run/ip_address", "127.0.0.1")
var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)


@export var selected_hero: PackedScene


func _ready() -> void:
    var is_server = ProjectSettings.get_setting("application/run/server", false)
    start(is_server)


func start(is_server: bool) -> void:
    multiplayer.connected_to_server.connect(self._on_connected_to_server)
    multiplayer.connection_failed.connect(self._on_connection_failed)
    multiplayer.server_disconnected.connect(self._on_server_disconnected)
    multiplayer.peer_connected.connect(self._on_peer_connected)
    multiplayer.peer_disconnected.connect(self._on_peer_disconnected)
    
    $MultiplayerSpawner.spawned.connect(self._on_spawned)
    $MultiplayerSpawner.spawn_function = _spawn_hero
    
    var peer: = ENetMultiplayerPeer.new()
    if is_server: peer.create_server(port)
    else: peer.create_client(host, port)
    
    multiplayer.multiplayer_peer = peer


func _on_spawned(node: Node) -> void:
    node.input.set_process(false)
    
    if node.player_id == multiplayer.get_unique_id():
        %Camera.target = node
        node.input.input_source = load("res://input/user_input.gd").new()
        node.input.set_process(true)


func _on_server_disconnected() -> void:
    print("Server disconnected")


func _on_connected_to_server() -> void:
    print("Connected to server!")


func _on_peer_connected(id: int) -> void:
    print("Client connected: %d" % id)
    
    if not multiplayer.is_server(): return
    
    $MultiplayerSpawner.spawn(id)


func _spawn_hero(id) -> Node:
    var hero_instance = selected_hero.instantiate()
    hero_instance.name = str(id)
    hero_instance.player_id = id
    hero_instance.set_multiplayer_authority(id, true)
    #hero_instance.team = index
    #hero_instance.position = %SpawnPoints.get_child(index).global_position
    return hero_instance


func _on_peer_disconnected(id: int) -> void:
    print("Client disconnected: %d" % id)
    
    if not $MultiplayerSpawner.has_node(str(id)): return
    $MultiplayerSpawner.get_node(str(id)).queue_free()


func _on_connection_failed() -> void:
    print("Failed connecting to server :(")


func _exit_tree() -> void:
    multiplayer.multiplayer_peer.close()
