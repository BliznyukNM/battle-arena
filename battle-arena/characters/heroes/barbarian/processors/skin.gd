extends Node


@export var skin: Node
@export var move_speed: NumberStat
@export var attack_speed: NumberStat
@export var interpolation: float


var _move_direction: Vector2


func _ready() -> void:
    await owner.ready
    
    skin.update_stance("axe")
    
    move_speed.changed.connect(_update_move_speed)
    attack_speed.changed.connect(_update_attack_speed)
    
    _update_attack_speed(0.0, move_speed.current_value)
    _update_attack_speed(0.0, attack_speed.current_value)


func _update_move_speed(old_value: float, new_value: float) -> void:
    if not is_processing(): return
    var move_speed_normalized: float = new_value / move_speed.base_value
    skin.update_move_speed(max(move_speed_normalized, 1.0))


func _update_attack_speed(old_value: float, new_value: float) -> void:
    if not is_processing(): return
    skin.update_attack_speed(new_value)


func _process(delta: float) -> void:
    var move_speed_normalized: float = move_speed.current_value / move_speed.base_value
    var velocity: Vector3 = owner.velocity
    var basis: Basis = owner.transform.basis
    var next_move_direction: = Vector2(velocity.dot(-basis.x), velocity.dot(basis.z)).normalized()
    _move_direction = _move_direction.lerp(next_move_direction, delta * interpolation)
    skin.update_move_direction(_move_direction * move_speed_normalized)
