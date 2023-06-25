extends Node


@export var health: NumberStat


func damage(value: int) -> void:
    if not health: return
    health.current_value -= value


func heal(value: int) -> void:
    if not health: return
    health.current_value += value
