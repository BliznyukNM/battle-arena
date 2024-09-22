@tool
extends BTDecorator


func _tick(delta: float) -> Status:
	if not agent.is_multiplayer_authority(): return FAILURE
	return get_child(0).execute(delta)
