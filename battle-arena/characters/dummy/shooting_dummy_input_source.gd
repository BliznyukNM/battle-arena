extends InputSource
    

func is_basic_attack_just_pressed() -> bool:
    var basic_attack = _owner.skills.basic_attack
    return basic_attack.execution.is_stopped() and basic_attack.cooldown.is_stopped()
