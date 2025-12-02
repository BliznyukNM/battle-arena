@tool
extends BTAction


@export var modifier_name: String


func _tick(delta: float) -> int:
	agent.modifiers.remove_modifier_by_name(modifier_name)
	return SUCCESS


func _generate_name() -> String:
	return "Remove [%s] modifier" % modifier_name
