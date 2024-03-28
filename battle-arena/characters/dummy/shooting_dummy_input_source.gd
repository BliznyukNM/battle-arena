extends InputSource
    

func is_basic_attack_just_pressed() -> bool:
    var basic_attack = _owner.skills.basic_attack
    return is_zero_approx(basic_attack.execution) and is_zero_approx(basic_attack.cooldown)


func get_look_at_point() -> Vector3:
    return _owner.position + _owner.transform.basis.z
