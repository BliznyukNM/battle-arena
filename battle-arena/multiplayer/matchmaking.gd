extends Node


signal match_found


#@onready var _client: = Nakama.create_client(server_key, ip, port, scheme, \
    #Nakama.DEFAULT_TIMEOUT, NakamaLogger.LOG_LEVEL.INFO)
#@onready var _socket: = Nakama.create_socket_from(_client)
#
#
#var _session: NakamaSession


const Database = preload("res://multiplayer/database.gd")


var ip: String:
    get: return ProjectSettings.get_setting_with_override("application/run/ip_address")
var port: int:
    get: return ProjectSettings.get_setting("application/run/port", 7350)
var scheme: String:
    get: return ProjectSettings.get_setting("application/run/network_scheme", "http")
var server_key: String:
    get: return ProjectSettings.get_setting_with_override("application/run/server_key")


#var is_authenticated: bool:
    #get: return _session != null


func _ready() -> void:
    var stun_url: String = ProjectSettings.get_setting_with_override("application/networking/stun")
    var ice_servers := [{"urls": [stun_url]}]

    W4GD.matchmaker.set_webrtc_ice_servers(ice_servers)
    Database.setup_mapper(W4GD.mapper)
    


func login(email: String, password: String):
    return await W4GD.auth.login_email(email, password).async()


func signup(email: String, password: String, username: String = '', picture_url: String = ''):
    var result = await W4GD.auth.signup_email(email, password).async()
    
    if not result.is_error():
        await Database.set_own_username(username)
        await Database.set_own_profile_picture(picture_url)
    
    return result
    #_session = await _client.authenticate_email_async(email, "password", username, create_account)
    
    # TODO: Save auth token
    
    #var connected: NakamaAsyncResult = await _socket.connect_async(_session)
    #assert(not connected.is_exception(), "Cannot create socket: %s" % connected)


#func update_account(display_name = null, avatar_url = null) -> bool:
    #var result = await _client.update_account_async(_session, null, display_name, avatar_url)
    #return not result.is_exception()


#func get_account(): # -> NakamaAPI.ApiAccount
    #return await _client.get_account_async(_session)


func get_profile() -> Database.Profile:
    return await Database.get_profile(W4GD.get_identity().get_uid())
    #var account: NakamaAPI.ApiAccount = await _client.get_account_async(_session)
    #assert(not account.is_exception(), "Cannot fetch account: %s" % account)
    #return account.user.username


const W4Matchmaker = preload("res://addons/w4gd/matchmaker/matchmaker.gd")
var matchmaker_ticket: W4Matchmaker.MatchmakerTicket


func find_match() -> void:
    if matchmaker_ticket:
        push_error("Cannot create more then one matchmaker ticket!")
        return
    
    var result = await W4GD.matchmaker.join_matchmaker_queue({
        # Arbitrary properties used to group players together.
        player_count = 2,
        network_type = "webrtc",
    }).async()
    if result.is_error():
        print("ERROR: ", result.message)
        return

    matchmaker_ticket = result.get_data()
    matchmaker_ticket.matched.connect(self._on_matchmaker_matched, CONNECT_ONE_SHOT)


func leave_match() -> void:
    if matchmaker_ticket == null:
        return

    await W4GD.matchmaker.leave_matchmaker_queue(matchmaker_ticket).async()
    matchmaker_ticket = null


func _on_matchmaker_matched(lobby_id: String) -> void:
    leave_match()
    
    var result = await W4GD.matchmaker.get_lobby(lobby_id).async()
    if result.is_error():
        print("ERROR: ", result.message)
        return

    var lobby: W4Matchmaker.Lobby = result.get_data()

    print("Matched into lobby with ID: ", lobby.id)
    match_found.emit()


func _exit_tree() -> void:
    # _socket.close()
    pass
