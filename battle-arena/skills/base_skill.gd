class_name BaseSkill extends Node


@export var skill_speed: NumberStat


signal activated(skill: BaseSkill)


@onready var cooldown: SkillTimer = $Cooldown
@onready var execution: SkillTimer = $Execution


var _collision_mask: int


func _ready() -> void:
    if owner: _collision_mask = owner.collision_mask & (~owner.collision_layer)


func activate(pressed: bool) -> void:
    if not cooldown.is_stopped(): return
    if pressed: _on_activate()


func _on_activate() -> void:
    var speed: = 1.0 if not skill_speed else 1.0 / skill_speed.current_value
    execution.activate(speed)
    cooldown.activate(speed)
    activated.emit(self)
