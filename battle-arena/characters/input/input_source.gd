class_name InputSource extends Resource


var _owner


func init(owner) -> void:
    _owner = owner


func is_basic_attack_just_pressed() -> bool:
    return false


func is_basic_attack_just_released() -> bool:
    return false


func is_secondary_attack_just_pressed() -> bool:
    return false


func is_secondary_attack_just_released() -> bool:
    return false


func is_third_attack_just_pressed() -> bool:
    return false


func is_third_attack_just_released() -> bool:
    return false


func is_block_just_pressed() -> bool:
    return false


func is_block_just_released() -> bool:
    return false


func is_dodge_just_pressed() -> bool:
    return false


func is_dodge_just_released() -> bool:
    return false


func is_ultimate_just_pressed() -> bool:
    return false


func is_ultimate_just_released() -> bool:
    return false


func is_cancel_just_pressed() -> bool:
    return false


func get_move_direction() -> Vector2:
    return Vector2()


func get_look_at_point() -> Vector3:
    return Vector3()
