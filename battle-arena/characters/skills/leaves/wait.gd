@tool
@icon("res://addons/beehave/icons/cooldown.svg")
extends ActionLeaf


@export var wait_time: = 0.0
@export var cache_key: = "waiting"


var scale: = 1.0


func before_run(actor: Node, blackboard: Blackboard) -> void:
    blackboard.set_value(cache_key, 1.0, owner.name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    if is_zero_approx(wait_time): return FAILURE
    
    var normalized_time_left: float = blackboard.get_value(cache_key, 0.0, owner.name)

    if not is_zero_approx(normalized_time_left):
        var scaled_time: = wait_time * scale
        var time_left: = normalized_time_left * scaled_time
        normalized_time_left = max((time_left - get_physics_process_delta_time()) / scaled_time, 0.0)
        blackboard.set_value(cache_key, normalized_time_left, owner.name)
        return RUNNING
    else:
        after_run(actor, blackboard)
        return SUCCESS


func interrupt(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)
    blackboard.erase_value(cache_key, owner.name)
