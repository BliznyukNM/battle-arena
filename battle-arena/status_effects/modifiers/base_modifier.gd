class_name BaseModifier extends Node


@export var effects: Array[BaseEffect]


func _ready() -> void:
    owner = get_parent().owner
    trigger_effects(true)


func _exit_tree() -> void:
    trigger_effects(false)


func trigger_effects(condition: bool) -> void:
    for effect in effects:
        if condition: effect.trigger(owner)
        else: effect.clear(owner)
