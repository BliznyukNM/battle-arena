class_name BaseSkill extends Node


@export var skill_speed: NumberStat


signal activated(skill: BaseSkill)
signal finished(skill: BaseSkill)
signal cancelled(skill: BaseSkill)


@onready var cooldown: SkillTimer = $Cooldown
@onready var execution: SkillTimer = $Execution


var _collision_mask: int


func _ready() -> void:
    _collision_mask = owner.collision_mask & (~owner.collision_layer)
    execution.timeout.connect(func():
        finished.emit(self)
        cooldown.activate()
    )


func activate(pressed: bool) -> void:
    if not cooldown.is_stopped(): return
    _on_activate(pressed)


func _on_activate(pressed: bool) -> void:
    var speed: = 1.0 if not skill_speed else 1.0 / skill_speed.current_value
    execution.activate(speed)
    activated.emit(self)


func cancel() -> void:
    execution.stop()
