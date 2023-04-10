extends Node


@export var input: PlayerInput
@export var speed: float = 5.0
@export var rotation_speed: float = 10.0


var _is_rotating: = true


func _process(delta: float) -> void:
    var movement: Vector2 = input.movement
    var velocity: = Vector3(movement.x, 0.0, movement.y)
    if velocity.length_squared() > 1: velocity = velocity.normalized()
    velocity *= speed
    
    owner.velocity = velocity
    owner.move_and_slide()
    
    if not _is_rotating: return
    
    var new_basis: Basis = Basis.looking_at(owner.position - input.look_at_point)
    var weight = delta * rotation_speed
    owner.transform.basis = lerp(owner.transform.basis, new_basis, weight)
    
    owner.rotation.x = 0.0
    owner.rotation.z = 0.0


func _on_skill_activate(skill: BaseSkill) -> void:
    _is_rotating = false
    await skill.execution.timeout
    _is_rotating = true
