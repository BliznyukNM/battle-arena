class_name BaseModifier extends Node


@export var effects: Array[BaseEffect]
@export var default_condition: bool = true


var _current_condition: bool:
    set(value):
        var old_value: = _current_condition
        _current_condition = value
        if old_value != value: _trigger_effects(_current_condition)


func get_bonus(stat: NumberStat) -> float:
    if not _current_condition: return 0.0
    
    var bonus: = 0.0
    
    for effect in effects:
        if not effect is EffectModifyNumberStat: continue
        bonus += effect.get_bonus(stat)
    
    return bonus


func has_effect(effect_name: String) -> bool:
    for effect in effects:
        if effect.name == effect_name: return true
    return false


func _ready() -> void:
    tree_exiting.connect(func(): self._current_condition = false)
    reset()


func _trigger_effects(condition: bool) -> void:
    for effect in effects:
        if condition: effect.apply(owner, self)
        else: effect.clear(owner, self)


func reset() -> void:
    self._current_condition = default_condition
