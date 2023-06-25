class_name HitBox extends Area3D


signal on_damage(value: int)
signal on_heal(value: int)


@export var processor_manager: Node


func _ready() -> void:
    collision_layer = owner.collision_layer


func register_damage(value: int) -> void:
    processor_manager.process_damage(value)
    on_damage.emit(value)


func register_heal(value: int) -> void:
    processor_manager.process_heal(value)
    on_damage.emit(value)
