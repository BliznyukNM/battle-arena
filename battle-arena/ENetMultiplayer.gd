extends Node


var host: String:
    get: return ProjectSettings.get_setting("application/run/ip_address", "127.0.0.1")
var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)


func _ready() -> void:
    multiplayer.connected_to_server.connect(self._on_connected_to_server)
    multiplayer.connection_failed.connect(self._on_connection_failed)
    multiplayer.server_disconnected.connect(self._on_server_disconnected)
    multiplayer.peer_connected.connect(self._on_peer_connected)
    multiplayer.peer_disconnected.connect(self._on_peer_disconnected)
    
    if not multiplayer.is_server(): return
    
    spawn_hero(multiplayer.get_unique_id(), get_parent().selected_hero) # FIXME


func _exit_tree() -> void:
    multiplayer.connected_to_server.disconnect(self._on_connected_to_server)
    multiplayer.connection_failed.disconnect(self._on_connection_failed)
    multiplayer.server_disconnected.disconnect(self._on_server_disconnected)
    multiplayer.peer_connected.disconnect(self._on_peer_connected)
    multiplayer.peer_disconnected.disconnect(self._on_peer_disconnected)


func _on_server_disconnected() -> void:
    print("Server disconnected")


func _on_connected_to_server() -> void:
    print("Connected to server!")
    spawn_hero.rpc_id(0, multiplayer.get_unique_id(), get_parent().selected_hero) # FIXME


func _on_peer_connected(id: int) -> void:
    print("Client connected: %d" % id)


@rpc("any_peer", "reliable")
func spawn_hero(player_id: int, hero_id: int) -> void:
    var params: = {
        "id" = player_id,
        "character" = hero_id
    }
    
    var team: = _get_priority_team()
    var hero: = team.spawn(params)
    team.spawned.emit(hero)


func _get_priority_team() -> MultiplayerSpawner:
    var team_a_count: int = %TeamA.count
    var team_b_count: int = %TeamB.count
    
    if team_a_count == team_b_count: return [%TeamA, %TeamB].pick_random()
    return %TeamA if team_a_count < team_b_count else %TeamB


func _on_peer_disconnected(id: int) -> void:
    print("Client disconnected: %d" % id)


func _on_connection_failed() -> void:
    print("Failed connecting to server :(")
