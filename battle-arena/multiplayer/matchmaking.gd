extends Node


@onready var _client: = Nakama.create_client(server_key, ip, port, scheme)
@onready var _socket: = Nakama.create_socket_from(_client)


var _session: NakamaSession


var ip: String:
    get: return ProjectSettings.get_setting("application/run/ip_address", "127.0.0.1")
var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)
var scheme: String:
    get: return ProjectSettings.get_setting("application/run/network_scheme", "http")
var server_key: String:
    get: return ProjectSettings.get_setting("application/run/server_key", "defaultkey")


func authenticate(username: String) -> bool:
    var device_id = OS.get_unique_id()
    _session = await _client.authenticate_device_async(device_id, username)
    
    # TODO: Save auth token
    
    assert(not _session.is_exception(), "Error while authenticating: %s" % _session)
    
    if _session.is_exception():
        return false
    
    var connected: NakamaAsyncResult = await _socket.connect_async(_session)
    assert(not connected.is_exception(), "Cannot create socket: %s" % connected)
    
    return not connected.is_exception()


func get_username() -> String:
    var account: NakamaAPI.ApiAccount = await _client.get_account_async(_session)
    assert(not account.is_exception(), "Cannot fetch account: %s" % account)
    return account.user.username
