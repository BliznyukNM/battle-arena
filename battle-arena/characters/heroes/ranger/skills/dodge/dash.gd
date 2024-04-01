@tool
extends ActionLeaf


@export var time: float


func before_run(actor: Node, blackboard: Blackboard) -> void:
    var options: Dictionary = blackboard.get_value("options", {}, owner.name)
    var character = actor.owner
    var target_transform: Transform3D = options.get("transform", character.transform)
    var target_position: = target_transform.origin
    
    character.transform.basis = Basis.looking_at(character.position - character.input.look_at_point)
    character.rotation.x = 0.0
    character.rotation.z = 0.0
    
    var tween = create_tween()
    tween.tween_property(character, "position", target_position, time).set_ease(Tween.EASE_OUT)
    blackboard.set_value("%d_tween" % self.get_instance_id(), tween, owner.name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    var tween: Tween = blackboard.get_value("%d_tween" % self.get_instance_id(), null, owner.name)
    if not tween: return FAILURE
    
    if tween.is_running(): return RUNNING
    blackboard.erase_value("%d_tween" % self.get_instance_id(), owner.name)
    return SUCCESS
