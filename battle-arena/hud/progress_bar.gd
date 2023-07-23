extends ProgressBar


var _skill: BaseSkill


func _ready() -> void:
    _clear_skill()


func register_skill(skill: BaseSkill) -> void:
    _skill = skill
    _skill.execution.timeout.connect(_clear_skill)
    value = 0
    
    visible = true


func _clear_skill() -> void:
    if _skill: _skill.execution.timeout.disconnect(_clear_skill)
    _skill = null
    visible = false


func _process(delta: float) -> void:
    if not _skill: return
    value = 1 - _skill.execution.time_left / _skill.execution.wait_time
