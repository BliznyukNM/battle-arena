## Handles triggering sequence of skills. Works only with 'pressed' state
extends Node


var _skills: Array[BaseSkill]
var _current_skill_number: int
var _skill_scheduled: bool


var current_skill: BaseSkill:
    get: return _skills[_current_skill_number]
var cooldown: Timer:
    get: return current_skill.cooldown
var execution: Timer:
    get: return current_skill.execution


func _ready() -> void:
    for child in get_children():
        var skill = child as BaseSkill
        _skills.append(skill)


func activate(pressed: bool) -> void:
    _skill_scheduled = pressed
    var is_fully_reset: = _current_skill_number == 0 and current_skill.cooldown.time_left <= 0.0
    if is_fully_reset: _trigger_skill_sequence()


func _trigger_skill_sequence() -> void:
    var force_schedule: = false # true wnen skill is activated by holding button
    while _skill_scheduled or force_schedule:
        if not current_skill.cooldown.is_stopped():
            await current_skill.cooldown.timeout

        force_schedule = false
        current_skill.activate(true)

        if not current_skill.execution.is_stopped():
            await current_skill.execution.timeout

        force_schedule = _skill_scheduled

        _current_skill_number = (_current_skill_number + 1) % _skills.size()
    _current_skill_number = 0
