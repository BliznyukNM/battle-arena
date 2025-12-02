@tool
extends BTDecorator


@export_enum("SUCCESS", "FAILURE") var result: int


func _tick(delta: float) -> int:
	var character: Character = agent.owner
	if character.multiplayer.get_unique_id() != character.player_id: return result
	return get_child(0).execute(delta)
