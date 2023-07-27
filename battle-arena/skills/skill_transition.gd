extends Node


@export_range(0, 4, 1, "or_greater") var current_index: int = 0


var _skills: Array
var _last_pressed: bool


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
    var old_skill = current_skill
    current_index = index
    if not old_skill.execution.is_stopped():
        old_skill.finish()
        current_skill.activate(_last_pressed)


func activate(pressed: bool) -> void:
    _last_pressed = pressed
    current_skill.activate(pressed)


func cancel() -> void:
    current_skill.cancel()


func finish() -> void:
    current_skill.finish()
