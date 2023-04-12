extends Area3D


@export var damage: int
@export var speed: float
@export var max_travel_distance: float


var _direction: Vector3
var _travelled_distance: float


func shoot(direction: Vector3) -> void:
    _direction = direction.normalized()


func _process(delta: float) -> void:
    var distance: = speed * delta
    position += _direction * distance
    _travelled_distance += distance
    
    if _travelled_distance >= max_travel_distance:
        queue_free()


func _on_area_entered(area: Area3D) -> void:
    if not area is HitBox: return
    area.on_hit.emit(damage)
    queue_free()
