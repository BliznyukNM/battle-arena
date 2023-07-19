extends Node


@export var skin: Node
@export var move_speed: NumberStat
@export var interpolation: float


var _move_direction: Vector2


func _ready() -> void:
    await owner.ready
    
    skin.update_stance("axe")
    
    var move_speed_normalized: float = move_speed.current_value / move_speed.base_value
    skin.update_move_speed(move_speed_normalized)


func _process(delta: float) -> void:
    var velocity: Vector3 = owner.velocity
    var basis: Basis = owner.transform.basis
    var next_move_direction: = Vector2(velocity.dot(-basis.x), velocity.dot(basis.z)).normalized()
    _move_direction = _move_direction.lerp(next_move_direction, delta * interpolation)
    skin.update_move_direction(_move_direction)
