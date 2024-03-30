@tool
extends "res://characters/skills/leaves/wait.gd"


@export_range(-100, 100, 1, "suffix:%") var initial_percentage: float


func tick(actor: Node, blackboard: Blackboard) -> int:
    var normalized_time_left: float = blackboard.get_value(cache_key, 0.0, owner.name)
    var charged_percentage: = (1 - normalized_time_left) * initial_percentage * 0.01 + (1 - initial_percentage * 0.01)
    blackboard.set_value("charged", charged_percentage, owner.name)
    return super(actor, blackboard)
