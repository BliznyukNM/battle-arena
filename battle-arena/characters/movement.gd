extends Node


@export var input: PlayerInput
@export var speed: float = 5.0


var _speed_modificator: = 1.0


func _process(delta: float) -> void:
    var movement: Vector2 = input.movement
    var velocity: = Vector3(movement.x, 0.0, movement.y)
    if velocity.length_squared() > 1: velocity = velocity.normalized()
    velocity *= speed * _speed_modificator
    
    owner.velocity = velocity
    owner.move_and_slide()


func _on_skill_activate(skill: BaseSkill) -> void:
    _speed_modificator = 0.5 # TODO: add status functionality
    await skill.execution.timeout
    _speed_modificator = 1.0
