@tool
extends MultiplayerSpawner


const Utils = preload("res://utils/spawner.gd")


func _ready() -> void:
    if Engine.is_editor_hint():
        _add_spawn_scenes()
        return
    
    spawn_function = _spawn
    
    for child in get_children(): child.respawn.connect(spawn)


func _add_spawn_scenes() -> void:
    for child in get_children():
        if not "spawn_scene" in child: continue
        Utils.try_add_scene(self, child.spawn_scene)
    

func _spawn(params) -> Node:
    var collectable_scene: PackedScene = load(params.path)
    var collectable: = collectable_scene.instantiate()
    collectable.position = params.position
    var spawn_node: = get_node(params.spawn_node)
    collectable.picked_up.connect(spawn_node.trigger_respawn, CONNECT_ONE_SHOT)
    return collectable
