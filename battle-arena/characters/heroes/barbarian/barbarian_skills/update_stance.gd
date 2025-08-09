@tool
extends BTAction


enum Stance { axe = 0, hands = 1 }


@export var stance: Stance


func tick(delta: float) -> int:
	var barbarian: Character = agent.owner
	barbarian.skin.update_stance(Stance.find_key(stance))
	# blackboard.set_value("skill_index", stance) TODO
	return SUCCESS
