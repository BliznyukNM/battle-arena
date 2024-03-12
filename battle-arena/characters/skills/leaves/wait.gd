@tool
@icon("res://addons/beehave/icons/cooldown.svg")
extends ActionLeaf


@export var wait_time: = 0.0
@export var cache_key: = "waiting"


func tick(actor: Node, blackboard: Blackboard) -> int:
    var time_left = blackboard.get_value(cache_key, 0.0, owner.name)

    if time_left > 0:
        time_left = max(time_left - get_physics_process_delta_time(), 0.0)
        blackboard.set_value(cache_key, time_left, owner.name)
        return RUNNING
    else:
        after_run(actor, blackboard)
        return SUCCESS


func before_run(actor: Node, blackboard: Blackboard) -> void:
    blackboard.set_value(cache_key, wait_time, owner.name)
