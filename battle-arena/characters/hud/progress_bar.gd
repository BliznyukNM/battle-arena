extends ProgressBar


var _skill: BaseSkill


func _ready() -> void:
    _clear()


func register_skill(skill: BaseSkill) -> void:
    _skill = skill
    _skill.execution.timeout.connect(_clear, CONNECT_ONE_SHOT)
    value = 0
    visible = true


func _clear() -> void:
    _skill = null
    visible = false


func _process(delta: float) -> void:
    if not _skill: return
    value = 1 - _skill.execution.time_left / _skill.execution.wait_time
