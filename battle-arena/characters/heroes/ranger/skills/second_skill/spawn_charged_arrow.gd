@tool
extends "res://characters/skills/leaves/spawn.gd"


func tick(actor: Node, blackboard: Blackboard) -> int:
    var charged_value: float = blackboard.get_value("charged", 1.0, owner.name)
    var character: Character = actor.owner
    var options = blackboard.get_value("options", {}, owner.name)
    var arrow = _spawn(character, options)
    arrow.distance *= charged_value
    arrow.damage *= charged_value
    arrow.energy_gain *= charged_value
    return SUCCESS
