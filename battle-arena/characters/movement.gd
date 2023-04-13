extends Node


@export var input: PlayerInput


@onready var speed: NumberStat = %Stats.get_stat("movement_speed")


func _process(delta: float) -> void:
    var movement: Vector2 = input.movement
    var velocity: = Vector3(movement.x, 0.0, movement.y)
    if velocity.length_squared() > 1: velocity = velocity.normalized()
    velocity *= speed.current_value
    
    owner.velocity = velocity
    owner.move_and_slide()
