@tool
@icon("res://addons/beehave/icons/cooldown.svg")
extends ActionLeaf


@export var wait_time: = 1.0
@export var cache_key: = "waiting"


const tween_delay: = 0.05


func before_run(actor: Node, blackboard: Blackboard) -> void:
    blackboard.set_value(cache_key, wait_time, owner.name)
    var tween: = create_tween().set_loops(int(wait_time / tween_delay) + 1).bind_node(self)
    tween.tween_callback(_update_time.bind(actor, blackboard)).set_delay(tween_delay)
    blackboard.set_value("tween", tween, owner.name)


func after_run(actor: Node, blackboard: Blackboard) -> void:
    var tween: Tween = blackboard.get_value("tween", null, owner.name)
    if tween: tween.kill()
    blackboard.erase_value("tween", owner.name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    if is_zero_approx(wait_time): return FAILURE
    
    var time_left: float = blackboard.get_value(cache_key, 0.0, owner.name)

    if not is_zero_approx(time_left):
        return RUNNING
    else:
        after_run(actor, blackboard)
        return SUCCESS


func _update_time(actor: Node, blackboard: Blackboard) -> void:
    var time_left: float = blackboard.get_value(cache_key, 0.0, owner.name)
    var scale: float = blackboard.get_value("scale", 1.0, owner.name)

    if is_zero_approx(time_left): return
    
    time_left = max(time_left - 0.05 * scale, 0.0)
    blackboard.set_value(cache_key, time_left, owner.name)


func interrupt(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)
    var tween: Tween = blackboard.get_value("tween", null, owner.name)
    if tween: tween.kill()
    blackboard.erase_value("tween", owner.name)
    blackboard.erase_value(cache_key, owner.name)
