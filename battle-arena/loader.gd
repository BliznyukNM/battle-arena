extends Node


func _process(delta: float) -> void:
    if Input.is_action_just_pressed("character.attack.basic"):
        $BasicAttack.blackboard.set_value("BasicAttack_ready", true)
    if Input.is_action_just_released("character.attack.basic"):
        $BasicAttack.blackboard.erase_value("BasicAttack_ready")
