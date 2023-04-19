class_name HitBox extends Area3D


signal on_hit(damage: float)


func _ready() -> void:
    collision_layer = owner.collision_layer
