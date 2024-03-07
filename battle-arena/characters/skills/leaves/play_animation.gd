@tool
class_name PlayAnimationLeaf extends Leaf


@export var animation_name: String
@export var duration: float


@onready var cache_key = 'animation_%d' % self.get_instance_id()


func before_run(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)
    var character = actor.owner
    
    blackboard.set_value(cache_key, 0.0, str(actor.get_instance_id()))
    character.skin.call("play_%s" % animation_name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    var time_left = blackboard.get_value(cache_key, 0.0, str(actor.get_instance_id()))

    if time_left < duration:
        time_left += get_physics_process_delta_time()
        blackboard.set_value(cache_key, time_left, str(actor.get_instance_id()))
        return RUNNING
    else:
        after_run(actor, blackboard)
        return SUCCESS
