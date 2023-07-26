class_name BaseSkill extends Node


@export var skill_speed: NumberStat


signal activated(skill: BaseSkill)
signal cancelled(skill: BaseSkill)


@onready var cooldown: SkillTimer = $Cooldown
@onready var execution: SkillTimer = $Execution


var _collision_mask: int


var speed: float:
    get: return 1.0 if not skill_speed else 1.0 / skill_speed.current_value


func _ready() -> void:
    _collision_mask = owner.collision_mask & (~owner.collision_layer)
    execution.timeout.connect(finish)


func activate(pressed: bool) -> void:
    if not cooldown.is_stopped(): return
    _on_activate(pressed)


func _on_activate(pressed: bool) -> void:
    execution.activate(speed)
    activated.emit(self)


func cancel() -> void:
    _stop_execution()
    cancelled.emit(self)
    cooldown.start(0.5)


func finish() -> void:
    _stop_execution()
    cooldown.activate()


func _stop_execution() -> void:
    if execution.is_stopped(): return
    execution.stop()
    execution.timeout.emit()
