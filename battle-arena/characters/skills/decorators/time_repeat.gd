@tool
@icon("res://addons/beehave/icons/delayer.svg")
extends EmptyDecorator


@export_enum("SUCCESS", "FAILURE") var result: int
@export var time: = 0.0
@export var cache_key: = "waiting"


func before_run(actor: Node, blackboard: Blackboard) -> void:
    blackboard.set_value(cache_key, time, owner.name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    if is_zero_approx(time): return FAILURE
    
    var time_left: float = blackboard.get_value(cache_key, 0.0, owner.name)
    
    if not is_zero_approx(time_left):
        time_left = max(time_left - get_physics_process_delta_time(), 0.0)
        blackboard.set_value(cache_key, time_left, owner.name)
        super(actor, blackboard)
        return RUNNING
    else:
        after_run(actor, blackboard)
        return result


func interrupt(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)
    blackboard.erase_value(cache_key, owner.name)
