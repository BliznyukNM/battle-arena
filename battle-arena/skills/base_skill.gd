class_name BaseSkill extends Area3D


signal activated(skill: BaseSkill)


@onready var cooldown: Timer = $Cooldown
@onready var execution: Timer = $Execution


func activate(pressed: bool) -> void:
    if pressed: _on_pressed()
    else: _on_released()


func _on_pressed() -> void: pass
func _on_released() -> void: pass
