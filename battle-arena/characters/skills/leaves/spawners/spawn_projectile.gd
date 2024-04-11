@tool
extends "res://characters/skills/leaves/spawners/spawn.gd"


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var options: Dictionary = blackboard.get_value("options", {}, owner.name)
    var arrow = _spawn(character, options)
    arrow.distance = options.get("distance", 0.0)
    arrow.damage = options.get("damage", 0.0)
    arrow.energy_gain = options.get("energy_gain", 0.0)
    return SUCCESS
