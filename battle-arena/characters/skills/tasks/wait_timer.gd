@tool
extends BTAction


@export var duration: float = 1.0
@export var blackboard_key: StringName


func _generate_name() -> String:
	var generated_name: = "Wait: %.1f sec" % duration
	if not blackboard_key.is_empty(): generated_name += ", %s" % blackboard_key
	return generated_name


func _tick(delta: float) -> Status:
	if not blackboard_key.is_empty():
		blackboard.top().set_var(blackboard_key, clamp(duration - elapsed_time, 0, duration))
	return SUCCESS if elapsed_time >= duration else RUNNING
