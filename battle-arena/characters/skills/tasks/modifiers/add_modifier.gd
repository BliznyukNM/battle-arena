@tool
extends BTAction


@export var modifier_name: String
@export_file("*.tscn") var scene_path: String


func _tick(delta: float) -> int:
	if not agent.is_multiplayer_authority(): return SUCCESS
	
	var options = blackboard.get_var("options", {}, false)
	options.path = scene_path
	options.name = modifier_name
	agent.modifiers.add_modifier(options)
	return SUCCESS


func _generate_name() -> String:
	return "Add [%s] modifier" % modifier_name


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
	
	var character: = Utils.get_character(agent.get_parent())
	if not character: return
	
	var spawner: MultiplayerSpawner = character.get_node("Modifiers/Spawner")
	Utils.try_add_scene(spawner, scene_path)
