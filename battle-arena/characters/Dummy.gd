extends Node3D


@export var health: float = 100:
    set(value):
        health = value
        health_bar.value = health
        

@onready var health_bar: = $SubViewport/HealthBar


func _ready() -> void:
    set_multiplayer_authority(1)
    
    health_bar.max_value = health
    health_bar.value = health


func apply_damage(damage: float) -> void:
    if not multiplayer.is_server(): return
    health -= damage
