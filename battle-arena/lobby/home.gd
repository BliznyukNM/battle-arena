extends Control


var offline_map: = preload("res://map/offline.tscn")
var online_map: = preload("res://map/online.tscn")


@onready var username: = $Username
@onready var play_online_button: Button = $PlayOnline
@onready var cance_matchmaking_button: Button = $PlayOnline/Cancel


func _ready() -> void:
    Matchmaking.match_found.connect(_on_match_found)
    if Matchmaking.is_authenticated: username.text = await Matchmaking.get_username()


func _on_match_found() -> void:
    _load_map(online_map)


func _on_play_offline() -> void:
    _load_map(offline_map)


func _on_play_online() -> void:
    Matchmaking.find_match()
    play_online_button.disabled = true
    cance_matchmaking_button.visible = true


func _on_cancel_matchmaking() -> void:
    Matchmaking.leave_match()
    _on_match_found()


func _load_map(map_scene: PackedScene) -> void:
    var map: Node = map_scene.instantiate()
    get_tree().root.add_child(map)
    get_tree().root.remove_child(self)
    queue_free()


func _on_change_username() -> void:
    print(username.text)
