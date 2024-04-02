extends Node


const SERVER_ID: = 1


var _rtt_time_start: int
var rtt: float


func _ready() -> void:
    Engine.register_singleton("Multiplayer", self)
    
    multiplayer.connected_to_server.connect(self._on_connected_to_server)
    multiplayer.connection_failed.connect(self._on_connection_failed)
    multiplayer.server_disconnected.connect(self._on_server_disconnected)
    multiplayer.peer_connected.connect(self._on_peer_connected)
    multiplayer.peer_disconnected.connect(self._on_peer_disconnected)
    
    if not multiplayer.is_server(): return
    
    await owner.ready
    owner.spawn_hero(multiplayer.get_unique_id(), owner.selected_hero)


func _exit_tree() -> void:
    Engine.unregister_singleton("Multiplayer")
    multiplayer.connected_to_server.disconnect(self._on_connected_to_server)
    multiplayer.connection_failed.disconnect(self._on_connection_failed)
    multiplayer.server_disconnected.disconnect(self._on_server_disconnected)
    multiplayer.peer_connected.disconnect(self._on_peer_connected)
    multiplayer.peer_disconnected.disconnect(self._on_peer_disconnected)


func _on_server_disconnected() -> void:
    print("Server disconnected")


func _on_connected_to_server() -> void:
    print("Connected to server!")
    update_rtt(SERVER_ID)
    owner.spawn_hero.rpc_id(SERVER_ID, multiplayer.get_unique_id(), owner.selected_hero) # FIXME


func _on_peer_connected(id: int) -> void:
    print("Client connected: %d" % id)


@rpc("any_peer", "reliable")
func update_rtt(id: int) -> void:
    if not multiplayer.is_server():
        rtt = (Time.get_ticks_msec() - _rtt_time_start) / 1000.0
        _rtt_time_start = Time.get_ticks_msec()
    update_rtt.rpc_id(id, multiplayer.get_unique_id())


func _get_priority_team() -> MultiplayerSpawner:
    var team_a_count: int = %TeamA.count
    var team_b_count: int = %TeamB.count
    
    if team_a_count == team_b_count: return [%TeamA, %TeamB].pick_random()
    return %TeamA if team_a_count < team_b_count else %TeamB


func _on_peer_disconnected(id: int) -> void:
    print("Client disconnected: %d" % id)


func _on_connection_failed() -> void:
    print("Failed connecting to server :(")
