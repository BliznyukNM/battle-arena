extends "res://characters/Weapon.gd"


@export var speed: = 5


var _direction: Vector3


func throw_direction(direction: Vector3) -> void:
    _direction = direction
    monitoring = true


func throw(point: Vector3) -> void:
    throw_direction((point - position).slide(Vector3.UP).normalized())


func _process(delta: float) -> void:
    translate(_direction * speed * delta)


func _on_area_entered(area: Area3D) -> void:
    super._on_area_entered(area)
    if multiplayer.is_server(): queue_free()
