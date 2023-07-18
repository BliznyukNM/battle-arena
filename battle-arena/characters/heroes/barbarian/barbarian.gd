extends "res://characters/character.gd"


@export var interpolation: float


var _move_direction: Vector2


func _ready() -> void:
    skin.update_stance("axe")
    
    var move_speed_stat: NumberStat = stats.get_stat("MovementSpeed")
    var move_speed_normalized: float = move_speed_stat.current_value / move_speed_stat.base_value
    skin.update_move_speed(move_speed_normalized)


func _process(delta: float) -> void:
    var next_move_direction: = Vector2(velocity.dot(-transform.basis.x), velocity.dot(transform.basis.z)).normalized()
    _move_direction = _move_direction.lerp(next_move_direction, delta * interpolation)
    skin.update_move_direction(_move_direction)
