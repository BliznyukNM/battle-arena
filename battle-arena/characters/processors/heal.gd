extends Node


@export var health: NumberStat


func apply(value: float) -> void:
    if not health: return
    health.current_value += value
