@tool
extends ActionLeaf


@export var distance: float
@export var time: float


func before_run(actor: Node, blackboard: Blackboard) -> void:
    var character = actor.owner
    var target_position = character.position + (character.input.look_at_point - character.position).limit_length(distance)
    
    character.transform.basis = Basis.looking_at(character.position - character.input.look_at_point)
    character.rotation.x = 0.0
    character.rotation.z = 0.0
    
    var tween = create_tween()
    tween.tween_property(character, "position", target_position + Vector3.UP * 4, time * 0.6) \
        .set_trans(Tween.TRANS_SINE).set_delay(time * 0.2).set_ease(Tween.EASE_OUT)
    tween.tween_property(character, "position", target_position, time * 0.2).set_trans(Tween.TRANS_EXPO)
    blackboard.set_value("%d_tween" % self.get_instance_id(), tween, owner.name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    var tween: Tween = blackboard.get_value("%d_tween" % self.get_instance_id(), null, owner.name)
    if not tween: return FAILURE
    
    if tween.is_running(): return RUNNING
    blackboard.erase_value("%d_tween" % self.get_instance_id(), owner.name)
    return SUCCESS
