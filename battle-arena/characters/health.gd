class_name Health extends Node


signal died


@export var max_value: int:
    set(value):
        max_value = value
        current_value = value


var current_value: float:
    set(value):
        current_value = clamp(value, 0, max_value)
        if (current_value <= 0): died.emit()


func damage(value: float) -> void:
    current_value -= value


func heal(value: float) -> void:
    current_value += value
