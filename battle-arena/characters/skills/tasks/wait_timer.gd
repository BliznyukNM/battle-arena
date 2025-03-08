@tool
extends BTAction


@export var duration: float = 1.0
@export var blackboard_key: StringName
@export var use_top_blackboard: bool = true


var used_blackboard: Blackboard:
	get: return blackboard if not use_top_blackboard else blackboard.top()


func _generate_name() -> String:
	var generated_name: = "Wait: %.1f sec" % duration
	if not blackboard_key.is_empty(): generated_name += ", %s" % blackboard_key
	return generated_name


func _exit() -> void:
	if not blackboard_key.is_empty(): used_blackboard.erase_var(blackboard_key)


func _tick(delta: float) -> Status:
	if not blackboard_key.is_empty(): used_blackboard.set_var(blackboard_key, elapsed_time)
	return SUCCESS if elapsed_time >= duration else RUNNING
