extends Node


signal died


@onready var health: NumberStat = %Stats.get_stat("health")


func damage(value: float) -> void:
    health.flat_value -= value
    if health.current_value <= 0: died.emit()


func heal(value: float) -> void:
    health.flat_value += value
