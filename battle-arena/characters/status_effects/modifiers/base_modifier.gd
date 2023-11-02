class_name BaseModifier extends Node


@export var effects: Array[BaseEffect]
@export var default_condition: bool = true


var _current_condition: bool:
    set(value):
        var old_value: = _current_condition
        _current_condition = value
        if old_value != value: _trigger_effects(_current_condition)


func _ready() -> void:
    tree_exiting.connect(func(): self._current_condition = false)
    _initialize.call_deferred()


func _initialize() -> void:
    self._current_condition = default_condition


func _trigger_effects(condition: bool) -> void:
    for effect in effects:
        if condition: effect.trigger(owner)
        else: effect.clear(owner)


func add_effect(effect: BaseEffect) -> void:
    effects.append(effect)
    if _current_condition: effect.trigger(owner)


func remove_effect(effect: BaseEffect) -> void:
    if not effects.has(effect): return
    if _current_condition: effect.clear(owner)
    effects.erase(effect)


func reset() -> void:
    _initialize()
