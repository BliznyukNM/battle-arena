extends Node


signal match_found


@onready var _client: = Nakama.create_client(server_key, ip, port, scheme, \
    Nakama.DEFAULT_TIMEOUT, NakamaLogger.LOG_LEVEL.INFO)
@onready var _socket: = Nakama.create_socket_from(_client)
@onready var _bridge: = NakamaMultiplayerBridge.new(_socket)


var _session: NakamaSession


var ip: String:
    get: return ProjectSettings.get_setting("application/run/ip_address", "127.0.0.1")
var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)
var scheme: String:
    get: return ProjectSettings.get_setting("application/run/network_scheme", "http")
var server_key: String:
    get: return ProjectSettings.get_setting("application/run/server_key", "defaultkey")


var is_authenticated: bool:
    get: return _session != null


func _ready() -> void:
    _bridge.match_joined.connect(_on_match_joined)
    _bridge.match_join_error.connect(func(error): assert(false, error))


func authenticate(id, username: String = '', create_account: bool = false) -> bool:
    _session = await _client.authenticate_email_async("%s@game.io" % id, "password", username, create_account)
    
    # TODO: Save auth token
    
    assert(not _session.is_exception(), "Error while authenticating: %s" % _session)
    
    if _session.is_exception():
        return false
    
    var connected: NakamaAsyncResult = await _socket.connect_async(_session)
    assert(not connected.is_exception(), "Cannot create socket: %s" % connected)
    
    multiplayer.multiplayer_peer = _bridge.multiplayer_peer
    
    return not connected.is_exception()


func get_username() -> String:
    var account: NakamaAPI.ApiAccount = await _client.get_account_async(_session)
    assert(not account.is_exception(), "Cannot fetch account: %s" % account)
    return account.user.username


func find_match() -> void:
    var ticket: = await _socket.add_matchmaker_async()
    assert(not ticket.is_exception(), "Matchmaking ticket is exception: %s" % ticket)
    _bridge.start_matchmaking(ticket)


func leave_match() -> void:
    _bridge.leave()


func _on_match_joined() -> void:
    match_found.emit()


func _exit_tree() -> void:
    _socket.close()
