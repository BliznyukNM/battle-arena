extends Node


@export var start_effects: Array[BaseStatusEffect]


var _status_effects: Array[BaseStatusEffect]


func _ready() -> void:
    for status_effect in start_effects:
        add_status_effect(status_effect)


func add_status_effect(effect: BaseStatusEffect) -> void:
    _status_effects.append(effect)
    effect.apply_stats_modifiers(%Stats)
    if effect.time <= 0.0: return
    create_tween().tween_callback(func(): remove_status_effect(effect)) \
        .set_delay(effect.time)


func remove_status_effect(effect: BaseStatusEffect) -> void:
    effect.clear_stats_modifiers(%Stats)
    _status_effects.erase(effect)
