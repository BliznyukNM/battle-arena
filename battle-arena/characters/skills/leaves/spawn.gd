@tool
extends ActionLeaf


@export_file("*.tscn") var scene_path: String


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var options: Dictionary = blackboard.get_value("options", {}, owner.name)
    _spawn(character, options)
    return SUCCESS


func _spawn(character: Character, options: Dictionary) -> Node:
    options.path = scene_path
    return character.spawner.spawn(options)


"""
↓ Editor only ↓
"""


var Utils = preload("res://characters/multiplayer/utils.gd")


func _ready() -> void:
    if not Engine.is_editor_hint(): return
    if not scene_path: return
    _add_autoload_scene()
    

func _add_autoload_scene() -> void:
    if not Engine.is_editor_hint():
        push_error("_add_autoload_scene is for Editor only")
        return
    
    var character: = Utils.get_character(get_parent())
    if not character: return
    
    var spawner: MultiplayerSpawner = character.get_node("LocalSpawner")
    Utils.try_add_scene(spawner, scene_path)
