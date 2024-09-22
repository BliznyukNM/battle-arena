@tool
extends BTAction


@export var variable: StringName


func _generate_name() -> String:
	return "AwaitTrigger %s" % ["???" if variable.is_empty() else "$" + variable]


func _tick(delta: float) -> Status:
	var has_trigger: bool = blackboard.get_var(variable, false, true)
	return SUCCESS if has_trigger else RUNNING
