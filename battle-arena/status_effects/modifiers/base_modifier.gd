class_name BaseModifier extends Node


@export var effects: Array[BaseEffect]


var _character


var _current_condition: bool:
    set(value):
        var old_value: = _current_condition
        _current_condition = value
        if old_value != value: _trigger_effects(_current_condition)


func register(character) -> void:
    _character = character


func _ready() -> void:
    assert(_character)
    _current_condition = true
    tree_exiting.connect(func(): _current_condition = false)


func _trigger_effects(condition: bool) -> void:
    for effect in effects:
        if condition: effect.trigger(_character)
        else: effect.clear(_character)


func add_effect(effect: BaseEffect) -> void:
    effects.append(effect)
    if _current_condition: effect.trigger(_character)


func remove_effect(effect: BaseEffect) -> void:
    if not effects.has(effect): return
    if _current_condition: effect.clear(_character)
    effects.erase(effect)
