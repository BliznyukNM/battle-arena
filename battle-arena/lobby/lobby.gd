extends Node


@onready var player_name_label: = $PlayerInfo/Name
@onready var player_avatar: = $PlayerInfo/Avatar


func _ready() -> void:
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
