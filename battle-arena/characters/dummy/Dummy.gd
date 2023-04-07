extends Node3D


@export var health: float = 100


var current_health: float:
    set(value):
        current_health = value
        if multiplayer.is_server() and current_health <= 0.0:
            queue_free()


var is_local: bool:
    get: return false


func _ready() -> void:
    set_multiplayer_authority(1)
    current_health = health


func apply_damage(damage: float) -> void:
    if not multiplayer.is_server(): return
    current_health -= damage
