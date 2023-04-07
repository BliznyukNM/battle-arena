extends Node3D


@export var target: Node:
    set(value):
        target = value
        $SubViewport/HUD/Container/Health.max_value = target.health
        $SubViewport/HUD/Container/Name.text = target.name


@onready var health_bar: = $SubViewport/HUD/Container/Health


func _process(_delta: float) -> void:
    if not target: return
    health_bar.value = target.current_health
