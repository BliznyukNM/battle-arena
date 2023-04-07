extends Node3D


@export var health: float = 100


var current_health: float


var is_local: bool:
    get: return false


func _ready() -> void:
    set_multiplayer_authority(1)
    current_health = health


func apply_damage(damage: float) -> void:
    if not multiplayer.is_server(): return
    current_health -= damage
