extends Area3D


@export var damage: int
@export var speed: float = 5
@export var max_travel_distance: float = 100


var _is_travelling: bool = true
var _travelled_distance: float


@onready var _direction: Vector3 = transform.basis.z


func _process(delta: float) -> void:
    if not _is_travelling: return
    
    var distance: = speed * delta
    position += _direction * distance
    _travelled_distance += distance
    
    if _travelled_distance >= max_travel_distance:
        _on_finish_travel()


func _on_finish_travel() -> void:
    queue_free()


func _on_area_entered(area: Area3D) -> void:
    if not area is HitBox: return
    area.on_damage.emit(damage)
    _on_finish_travel()
