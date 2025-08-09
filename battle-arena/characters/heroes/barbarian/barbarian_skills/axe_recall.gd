@tool
extends BTAction


func _tick(delta: float) -> int:
	if agent.is_multiplayer_authority() and agent.thrown_axe and not agent.is_recalling: agent.recall_axe.rpc()
	return RUNNING if agent.is_recalling else SUCCESS
