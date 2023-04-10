extends Node


@export var input: PlayerInput
@export var speed: float = 5.0
@export var rotation_speed: float = 10.0


func _process(delta: float) -> void:
    var movement: Vector2 = input.movement
    var velocity: = Vector3(movement.x, 0.0, movement.y)
    if velocity.length_squared() > 1: velocity = velocity.normalized()
    velocity *= speed
    
    owner.velocity = velocity
    owner.move_and_slide()
    
    var new_basis: Basis = Basis.looking_at(owner.position - input.look_at_point)
    var weight = delta * rotation_speed
    owner.transform.basis = lerp(owner.transform.basis, new_basis, weight)
