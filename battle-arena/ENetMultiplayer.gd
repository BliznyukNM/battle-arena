extends Node


var host: String:
    get: return ProjectSettings.get_setting("application/run/ip_address", "127.0.0.1")
var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)


@export var selected_hero: int


func _ready() -> void:
    start()


func start() -> void:
    multiplayer.connected_to_server.connect(self._on_connected_to_server)
    multiplayer.connection_failed.connect(self._on_connection_failed)
    multiplayer.server_disconnected.connect(self._on_server_disconnected)
    multiplayer.peer_connected.connect(self._on_peer_connected)
    multiplayer.peer_disconnected.connect(self._on_peer_disconnected)
    
    $HeroSpawner.spawned.connect(self._on_spawned)
    $HeroSpawner.spawn_function = _spawn_hero
    
    if not multiplayer.is_server(): return
    
    for peer in multiplayer.get_peers():
        _on_peer_connected(peer)
    _on_peer_connected(multiplayer.get_unique_id())


func _on_spawned(node: Node) -> void:
    if node.player_id == multiplayer.get_unique_id():
        %Camera.target = node
        %GUI.target = node
        node.input.input_source = load("res://characters/input/user_input.gd").new()


func _on_server_disconnected() -> void:
    print("Server disconnected")


func _on_connected_to_server() -> void:
    print("Connected to server!")


func _on_peer_connected(id: int) -> void:
    print("Client connected: %d" % id)
    
    if not multiplayer.is_server(): return
    var params: = {
        "id" = id,
        "position" = [Vector3(-5, 0, 0), Vector3(5, 0, 0)][$HeroSpawner.get_child_count()],
        "team" = $HeroSpawner.get_child_count() + 1
    }
    
    var hero: Node = $HeroSpawner.spawn(params)
    _on_spawned(hero)


func _spawn_hero(params: Dictionary) -> Node:
    var hero_instance = load($HeroSpawner.get_spawnable_scene(selected_hero)).instantiate()
    hero_instance.name = str(params.id)
    hero_instance.player_id = params.id
    hero_instance.get_node("Input").set_multiplayer_authority(params.id)
    hero_instance.collision_layer = 1 << params.team # TODO: temporary
    hero_instance.position = params.position
    return hero_instance


func _on_peer_disconnected(id: int) -> void:
    print("Client disconnected: %d" % id)
    
    if not $HeroSpawner.has_node(str(id)): return
    $HeroSpawner.get_node(str(id)).queue_free()


func _on_connection_failed() -> void:
    print("Failed connecting to server :(")
