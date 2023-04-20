class_name BaseModifier extends Node


@export var effects: Array[BaseEffect]


var _current_condition: bool:
    set(value):
        var old_value: = _current_condition
        _current_condition = value
        if old_value != value: trigger_effects(_current_condition)


func _ready() -> void:
    owner = get_parent().owner
    _current_condition = true


func _exit_tree() -> void:
    _current_condition = false


func trigger_effects(condition: bool) -> void:
    for effect in effects:
        if condition: effect.trigger(owner)
        else: effect.clear(owner)
