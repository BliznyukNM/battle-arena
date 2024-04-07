@tool
extends Node3D


signal respawn(params)


@export_file("*.tscn") var scene_path: String
@export var respawn_time: float = 1.0


func _ready() -> void:
    trigger_respawn()


func trigger_respawn() -> void:
    var tween = create_tween()
    if not tween: return
    
    var params = {
        "path": scene_path,
        "position": position,
        "spawn_node": get_parent().get_path_to(self)
    }
    var callback: = func(): respawn.emit(params)
    tween.bind_node(self).tween_callback(callback).set_delay(respawn_time)
