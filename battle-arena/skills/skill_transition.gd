extends Node


@export_range(0, 4, 1, "or_greater") var current_index: int = 0


var _skills: Array


var current_skill:
    get: return _skills[current_index]
var execution: Timer:
    get: return current_skill.execution
var cooldown: Timer:
    get: return current_skill.cooldown


func _ready() -> void:
    for child in get_children():
        var skill = child
        _skills.append(skill)


func select(index: int) -> void:
    current_index = index


func activate(pressed: bool) -> void:
    current_skill.activate(pressed)


func cancel() -> void:
    current_skill.cancel()


func finish() -> void:
    current_skill.finish()
