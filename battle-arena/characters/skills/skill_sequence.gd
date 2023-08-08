## Handles triggering sequence of skills. Works only with 'pressed' state
class_name SkillSequence extends BaseSkill


var _current_skill_number: int
var _skill_scheduled: bool


var current_skill:
    get: return get_child(_current_skill_number)


func _ready() -> void:
    pass


func _get_cooldown() -> SkillTimer:
    return current_skill.cooldown


func _get_execution() -> SkillTimer:
    return current_skill.execution


func activate(pressed: bool) -> void:
    if not is_multiplayer_authority(): return
    _skill_scheduled = pressed
    var is_fully_reset: = _current_skill_number == 0 and execution.is_stopped() and cooldown.is_stopped()
    if pressed and is_fully_reset: _trigger_skill_sequence()


func finish() -> void:
    if not is_multiplayer_authority(): return
    if execution.is_stopped(): return
    _skill_scheduled = false
    _current_skill_number = 0
    current_skill.finish()


func cancel() -> void:
    if not is_multiplayer_authority(): return
    if execution.is_stopped(): return
    _skill_scheduled = false
    _current_skill_number = 0
    current_skill.cancel()


func _trigger_skill_sequence() -> void:
    while _skill_scheduled:
        if not current_skill.cooldown.is_stopped():
            await current_skill.cooldown.timeout

        current_skill.activate(true)

        if not current_skill.execution.is_stopped():
            await current_skill.execution.timeout

        _current_skill_number = (_current_skill_number + 1) % get_child_count()
    _current_skill_number = 0
