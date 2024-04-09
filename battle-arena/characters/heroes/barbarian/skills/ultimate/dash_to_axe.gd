@tool
extends ActionLeaf


@export var time: float


func before_run(actor: Node, blackboard: Blackboard) -> void:
    var character = actor.owner
    var axe: Node3D = character.thrown_axe
    var target_position: Vector3 = (character.position + axe.position) / 2
    target_position.y = character.position.y
    
    var distance: Vector3 = (axe.position - character.position)
    var velocity: = distance / time
    
    blackboard.set_value("velocity", velocity, owner.name)


func tick(actor: Node, blackboard: Blackboard) -> int:
    var barbarian: Character = actor.owner
    var axe: Node3D = barbarian.thrown_axe
    
    if not axe: return SUCCESS
    
    var velocity: Vector3 = blackboard.get_value("velocity", Vector3.ZERO, owner.name)
    barbarian.move_and_collide(velocity * get_process_delta_time())
    
    return RUNNING
