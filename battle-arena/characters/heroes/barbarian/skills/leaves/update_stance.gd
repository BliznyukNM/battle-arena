@tool
extends ActionLeaf


enum Stance { axe = 0, hands = 1 }


@export var stance: Stance


func tick(actor: Node, blackboard: Blackboard) -> int:
    var barbarian: Character = actor.owner
    barbarian.skin.update_stance(Stance.find_key(stance))
    blackboard.set_value("skill_index", stance)
    return SUCCESS
