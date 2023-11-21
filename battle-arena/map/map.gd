extends Node3D


var selected_hero: String = "druid" # FIXME


func _ready() -> void:
    $PauseMenu.exit_game.connect(exit_game)


func exit_game() -> void:
    var lobby_scene: PackedScene = load("res://lobby/lobby.tscn")
    var lobby: = lobby_scene.instantiate()
    get_tree().root.add_child(lobby)
    get_tree().root.remove_child(self)
    queue_free()
