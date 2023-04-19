## Handles triggering sequence of skills. Currently works only with 'pressed'
## state.
extends Node


var _skills: Array[BaseSkill]
var _current_skill_number: int
var _skill_scheduled: bool


var current_skill: BaseSkill:
    get: return _skills[_current_skill_number]

var is_ready: bool:
    get: return _current_skill_number == 0 and current_skill.cooldown.time_left <= 0.0


func _ready() -> void:
    for child in get_children():
        var skill = child as BaseSkill
        _skills.append(skill)


func activate(pressed: bool) -> void:
    _skill_scheduled = pressed
    if is_ready: _trigger_next_skill()


func _trigger_next_skill() -> void:
    var force_schedule: = false
    while _skill_scheduled or force_schedule:
        force_schedule = false
        current_skill.activate(true)
        if not current_skill.execution.is_stopped():
            await current_skill.execution.timeout
        force_schedule = _skill_scheduled
        if not current_skill.cooldown.is_stopped():
            await current_skill.cooldown.timeout
        _current_skill_number = (_current_skill_number + 1) % _skills.size()
    _current_skill_number = 0
