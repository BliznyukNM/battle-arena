@tool
extends BTDecorator


func _tick(delta: float) -> Status:
	var cancel = blackboard.get_var("cancel", false, false)
	
	if cancel:
		blackboard.erase_var("cancel")
		return FAILURE
	
	return get_child(0).execute(delta)
