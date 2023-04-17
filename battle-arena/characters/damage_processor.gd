extends Node


@export var health: NumberStat


signal death


func damage(value: float) -> void:
    health.current_value -= value
    if health.current_value <= 0.0: death.emit()


func heal(value: float) -> void:
    health.current_value += value
