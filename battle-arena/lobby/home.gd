extends Control


var offline_map: = preload("res://map/offline.tscn")
var online_map: = preload("res://map/online.tscn")


@onready var username: = $Username


func _ready() -> void:
    username.text = await Matchmaking.get_username()


func _on_play_offline() -> void:
    _load_map(offline_map)


func _on_play_online() -> void:
    _load_map(online_map)


func _load_map(map_scene: PackedScene) -> void:
    var map: Node = map_scene.instantiate()
    get_tree().root.add_child(map)
    get_tree().root.remove_child(self)
    queue_free()
