class_name Weapon extends Area3D


@export var damage: Array[float]


var _current_damage: float
var _damaged_bodies: Array[Area3D]


func set_attack_number(attack_number: int) -> void:
    _damaged_bodies.clear()
    _current_damage = damage[attack_number]


func _on_area_entered(area: Area3D) -> void:
    if not area is HitBox or _damaged_bodies.has(area): return
    _damaged_bodies.append(area)
    area.on_hit.emit(_current_damage)
