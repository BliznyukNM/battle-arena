@tool
@icon("res://addons/beehave/icons/cooldown.svg")
extends Leaf


@export var wait_time: = 0.0


@onready var cache_key = '%s_cooldown' % owner.name


func tick(actor: Node, blackboard: Blackboard) -> int:
    var time_left = blackboard.get_value(cache_key, 0.0, str(actor.get_instance_id()))

    if time_left < wait_time:
        time_left += get_physics_process_delta_time()
        blackboard.set_value(cache_key, time_left, str(actor.get_instance_id()))
        return RUNNING
    else:
        after_run(actor, blackboard)
        return SUCCESS


func before_run(actor: Node, blackboard: Blackboard) -> void:
    blackboard.set_value(cache_key, 0.0, str(actor.get_instance_id()))
