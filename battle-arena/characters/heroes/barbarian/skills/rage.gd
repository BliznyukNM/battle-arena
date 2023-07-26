extends "res://skills/chanelling_skill.gd"


@export_range(0.1, 10, 0.1, "or_greater", "suffix:sec") var rage_length: float = 1.0
@export var rage_modifier: PackedScene


func on_damage(damage: float) -> void:
    _apply_rage()


func _apply_rage() -> void:
    if execution.is_stopped(): return
    var rage: TimedModifier = rage_modifier.instantiate()
    rage.time = rage_length
    owner.modifiers.add_modifier(rage)
    finish()
