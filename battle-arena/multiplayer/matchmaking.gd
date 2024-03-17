extends Node


signal match_found


@onready var _client: = Nakama.create_client(server_key, ip, port, scheme, \
    Nakama.DEFAULT_TIMEOUT, NakamaLogger.LOG_LEVEL.INFO)
@onready var _socket: = Nakama.create_socket_from(_client)


var _session: NakamaSession


var ip: String:
    get: return ProjectSettings.get_setting_with_override("application/run/ip_address")
var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)
var scheme: String:
    get: return ProjectSettings.get_setting("application/run/network_scheme", "http")
var server_key: String:
    get: return ProjectSettings.get_setting_with_override("application/run/server_key")


var is_authenticated: bool:
    get: return _session != null


func _ready() -> void:
    NakamaWebRTC.max_players = 2
    NakamaWebRTC.match_ready.connect(_on_match_ready)
    NakamaWebRTC.error.connect(func(error): push_error(error))


func authenticate(email: String, password: String, username: String = '', create_account: bool = false) -> bool:
    _session = await _client.authenticate_email_async(email, "password", username, create_account)
    
    # TODO: Save auth token
    
    if _session.is_exception():
        return false
    
    var connected: NakamaAsyncResult = await _socket.connect_async(_session)
    assert(not connected.is_exception(), "Cannot create socket: %s" % connected)
    
    return not connected.is_exception()


func update_account(display_name = null, avatar_url = null) -> bool:
    var result = await _client.update_account_async(_session, null, display_name, avatar_url)
    return not result.is_exception()


func get_account(): # -> NakamaAPI.ApiAccount
    return await _client.get_account_async(_session)


func get_username() -> String:
    var account: NakamaAPI.ApiAccount = await _client.get_account_async(_session)
    assert(not account.is_exception(), "Cannot fetch account: %s" % account)
    return account.user.username


func find_match() -> void:
    NakamaWebRTC.start_matchmaking(_socket)


func leave_match() -> void:
    NakamaWebRTC.leave()


func _on_match_ready(players: Dictionary) -> void:
    match_found.emit()


func _exit_tree() -> void:
    _socket.close()
