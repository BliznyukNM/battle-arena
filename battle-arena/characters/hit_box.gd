class_name HitBox extends Area3D


signal on_damage(value: int)
signal on_heal(value: int)


func _ready() -> void:
    collision_layer = owner.collision_layer
