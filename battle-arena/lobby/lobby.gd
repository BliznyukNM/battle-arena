extends Node


@onready var player_name_label: = $PlayerInfo/Name
@onready var player_avatar: = $PlayerInfo/Avatar
@onready var viewport_root: = $SubViewport


var semaphore: = Semaphore.new()


func _ready() -> void:
    semaphore.post()
    select_hero("barbarian") # FIXME
    
    if not Matchmaking.is_authenticated: return
    
    var account: NakamaAPI.ApiAccount = await Matchmaking.get_account()
    var user: NakamaAPI.ApiUser = account.user
    player_name_label.text = user.display_name
    
    var httpRequest: = HTTPRequest.new()
    add_child(httpRequest)
    httpRequest.request_completed.connect(_on_avatar_request_completed)
    httpRequest.request(user.avatar_url)


func _on_avatar_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
    var image: = Image.new()
    if image.load_jpg_from_buffer(body) != OK:
        push_error("Cannot load avatar")
    
    player_avatar.texture = ImageTexture.create_from_image(image)


func select_hero(id: String) -> void:
    if not semaphore.try_wait(): return
    
    var current_skin: = viewport_root.get_node_or_null("Skin")
    
    if current_skin:
        viewport_root.remove_child(current_skin)
        current_skin.queue_free()
    
    WorkerThreadPool.add_task(
        func():
            var skin_scene: PackedScene = load("res://characters/heroes/%s/skin.tscn" % id)
            var skin = skin_scene.instantiate()
            skin.ready.connect(semaphore.post)
            viewport_root.add_child.call_deferred(skin)
    )
