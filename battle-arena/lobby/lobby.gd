extends Node


@onready var player_name_label: = $PlayerInfo/Name
@onready var player_avatar: = $PlayerInfo/Avatar
@onready var viewport_root: = $SubViewport


const offline_map: = "res://map/offline.tscn"
const online_map: = "res://map/arena/arena_1.tscn"


var _semaphore: = Semaphore.new()
var _loading_task_id: int
var _selected_hero: String


func _ready() -> void:
    _semaphore.post()
    select_hero("barbarian") # FIXME
    
    # if not Matchmaking.is_authenticated: return
    Matchmaking.match_found.connect(_on_match_found)
    
    # var account: NakamaAPI.ApiAccount = await Matchmaking.get_account()
    # var user: NakamaAPI.ApiUser = account.user
    var profile = await Matchmaking.get_profile()
    player_name_label.text = profile.username
    
    if profile.picture_url.is_empty(): return
    
    var httpRequest: = HTTPRequest.new()
    add_child(httpRequest)
    httpRequest.request_completed.connect(_on_avatar_request_completed)
    httpRequest.request(profile.picture_url)


func _on_avatar_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
    var image: = Image.new()
    
    if "Content-Type: image/png" in headers:
        if image.load_png_from_buffer(body) != OK:
            push_error("Cannot load avatar")
            return
    else:
        return
    
    player_avatar.texture = ImageTexture.create_from_image(image)


func start_sandbox() -> void:
    var offline_peer: = OfflineMultiplayerPeer.new()
    _load_map(offline_map, offline_peer)


func start_matchmaking() -> void:
    Matchmaking.find_match()


func _load_map(map_path: String, peer: MultiplayerPeer) -> void:
    var map_scene: PackedScene = load(map_path)
    var map: Node = map_scene.instantiate()
    map.selected_hero = _selected_hero # FIXME
    map.tree_entered.connect(func(): map.multiplayer.multiplayer_peer = peer, CONNECT_ONE_SHOT)
    get_tree().root.add_child(map)
    get_tree().root.remove_child(self)
    queue_free()


func _on_match_found() -> void:
    _load_map(online_map, multiplayer.multiplayer_peer)


func select_hero(id: String) -> void:
    if not _semaphore.try_wait(): return
    
    _selected_hero = id
    var current_skin: = viewport_root.get_node_or_null("Skin")
    
    if current_skin:
        viewport_root.remove_child(current_skin)
        current_skin.queue_free()
    
    _loading_task_id = WorkerThreadPool.add_task(
        func():
            var skin_scene: PackedScene = load("res://characters/heroes/%s/skin.tscn" % id)
            var skin = skin_scene.instantiate()
            skin.ready.connect(_semaphore.post)
            viewport_root.add_child.call_deferred(skin)
    )


func _exit_tree() -> void:
    WorkerThreadPool.wait_for_task_completion(_loading_task_id)
