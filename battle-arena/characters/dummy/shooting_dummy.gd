extends Node3D


@onready var skill: BaseSkill = $RangeAttack


func _process(delta: float) -> void:
    if not skill.cooldown.is_stopped(): return
    skill.activate(true)
