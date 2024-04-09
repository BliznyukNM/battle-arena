@tool
extends Node3D


signal respawn(params)


@export_file("*.tscn") var scene_path: String
@export var respawn_time: float = 1.0
@export var immediate_initial_spawn: = true


func _ready() -> void:
    if not is_multiplayer_authority(): return
    trigger_respawn(0.0 if immediate_initial_spawn else respawn_time)


func trigger_respawn(time: float = -1) -> void:
    if time < 0.0: time = respawn_time
    var tween = create_tween()
    
    var params = {
        "path": scene_path,
        "position": position,
        "spawn_node": get_parent().get_path_to(self)
    }
    var callback: = func(): respawn.emit(params)
    tween.bind_node(self).tween_callback(callback).set_delay(time)
