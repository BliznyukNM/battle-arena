@tool
extends "res://characters/skills/leaves/spawn.gd"


func tick(actor: Node, blackboard: Blackboard) -> int:
    var charged_value: float = blackboard.get_value("charged", 1.0, owner.name)
    var character: Character = actor.owner
    var arrow = _spawn(character)
    arrow.distance *= charged_value
    arrow.damage *= charged_value
    return SUCCESS
