extends Node


@export var input: PlayerInput
@export var movement_speed: NumberStat


func _process(delta: float) -> void:
    if not input: return
    
    var movement: Vector2 = input.movement
    var velocity: = Vector3(movement.x, 0.0, movement.y)
    if velocity.length_squared() > 1: velocity = velocity.normalized()
    velocity *= movement_speed.current_value
    
    owner.velocity = velocity
    owner.move_and_slide()
