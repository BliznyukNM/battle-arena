extends Node


signal died


@onready var health: NumberStat = %Stats.get_stat("health")


func _ready() -> void:
    health.value_changed.connect(self._on_health_value_changed)


func _on_health_value_changed(old_value: float, new_value: float) -> void:
    if new_value <= 0: died.emit()


func damage(value: float) -> void:
    health.current_value -= value


func heal(value: float) -> void:
    health.current_value += value
