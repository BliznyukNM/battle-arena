extends Node


@export var health: NumberStat


func apply(source: Character, value: float) -> void:
    if not health: return
    health.current_value += value
