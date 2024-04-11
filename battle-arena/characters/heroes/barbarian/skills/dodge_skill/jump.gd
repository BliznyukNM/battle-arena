@tool
extends ActionLeaf


@export var time: float


func before_run(actor: Node, blackboard: Blackboard) -> void:
    var options: Dictionary = blackboard.get_value("options", {}, owner.name)
    var character = actor.owner
    # var target_position = character.position + (character.input.look_at_point - character.position).limit_length(distance)
    var target_transform: Transform3D = options.get("target", character.transform)
    var target_position: = target_transform.origin
    
    character.transform.basis = Basis.looking_at(character.position - character.input.look_at_point)
    character.rotation.x = 0.0
    character.rotation.z = 0.0
    
    var tween = create_tween()
    tween.tween_property(character, "position", target_position + Vector3.UP * 4, time * 0.6) \
        .set_trans(Tween.TRANS_SINE).set_delay(time * 0.2).set_ease(Tween.EASE_OUT)
    tween.tween_property(character, "position", target_position, time * 0.2).set_trans(Tween.TRANS_EXPO)
    blackboard.set_value("%d_tween" % self.get_instance_id(), tween, owner.name)
    blackboard.set_value("execution", time, owner.name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    var tween: Tween = blackboard.get_value("%d_tween" % self.get_instance_id(), null, owner.name)
    if not tween: return FAILURE
    
    var time_left: float = blackboard.get_value("execution", 0.0, owner.name)
    blackboard.set_value("execution", max(time_left - get_process_delta_time(), 0.0), owner.name)
    
    if tween.is_running(): return RUNNING
    blackboard.erase_value("%d_tween" % self.get_instance_id(), owner.name)
    blackboard.erase_value("execution", owner.name)
    return SUCCESS
