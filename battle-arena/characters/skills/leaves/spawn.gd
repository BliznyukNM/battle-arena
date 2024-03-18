@tool
extends ActionLeaf


@export_file("*.tscn") var scene_path: String


var spawn_transform: Transform3D


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    character.spawner.spawn({
        "path": scene_path,
        "transform": spawn_transform,
    })
    return SUCCESS


"""
↓ Editor only ↓
"""


func _ready() -> void:
    if not Engine.is_editor_hint(): return
    _add_autoload_scene()


func _add_autoload_scene() -> void:
    if not Engine.is_editor_hint():
        push_error("_add_autoload_scene is for Editor only")
        return
    
    if not scene_path: return
    
    var character: = _get_character(get_parent())
    if not character: return
    
    var spawner: MultiplayerSpawner = character.get_node("LocalSpawner")
    _try_add_scene(spawner)


func _get_character(node: Node) -> Character:
    if not Engine.is_editor_hint():
        push_error("_get_character is for Editor only")
        return
    
    if node == get_tree().root: return null
    if node is Character: return node
    return _get_character(node.get_parent())


func _try_add_scene(spawner: MultiplayerSpawner) -> void:
    if not Engine.is_editor_hint():
        push_error("_try_add_scene is for Editor only")
        return
    
    for i in range(spawner.get_spawnable_scene_count()):
        if spawner.get_spawnable_scene(i) == scene_path: return
    spawner.add_spawnable_scene(scene_path)
