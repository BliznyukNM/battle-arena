@tool
extends MultiplayerSpawner


@export_file("*.tscn") var collectable_scene_path: String
@export var respawn_time: float = 1.0


const Utils = preload("res://utils/spawner.gd")


func _ready() -> void:
    if Engine.is_editor_hint():
        Utils.try_add_scene(self, collectable_scene_path)
        return
    
    spawn_function = _spawn
    
    if is_multiplayer_authority(): _respawn()
    

func _spawn(params) -> Node:
    var collectable_scene: PackedScene = load(collectable_scene_path)
    var collectable: = collectable_scene.instantiate()
    collectable.tree_exited.connect(_respawn, CONNECT_ONE_SHOT)
    return collectable


func _respawn() -> void:
    var tween = create_tween()
    if not tween: return
    tween.bind_node(self).tween_callback(spawn).set_delay(respawn_time)
