class_name UserInput extends InputSource


var _camera: Camera3D:
    get:
        if _camera == null: _camera = _owner.get_viewport().get_camera_3d()
        return _camera


func is_basic_attack_just_pressed() -> bool:
    return Input.is_action_just_pressed("character.attack.basic")


func is_basic_attack_just_released() -> bool:
    return Input.is_action_just_released("character.attack.basic")


func is_secondary_attack_just_pressed() -> bool:
    return Input.is_action_just_pressed("character.attack.strong")


func is_secondary_attack_just_released() -> bool:
    return Input.is_action_just_released("character.attack.strong")


func is_third_attack_just_pressed() -> bool:
    return Input.is_action_just_pressed("character.attack.third")


func is_third_attack_just_released() -> bool:
    return Input.is_action_just_released("character.attack.third")


func is_block_just_pressed() -> bool:
    return Input.is_action_just_pressed("character.attack.block")


func is_block_just_released() -> bool:
    return Input.is_action_just_released("character.attack.block")


#func is_cancel_just_pressed() -> bool:
#    return Input.is_action_just_pressed("character.attack.cancel")


func get_look_at_point() -> Vector3:
    var look_at_point: = Vector3()
    
    if _camera:
        var plane: = Plane(Vector3.UP)
        var mouse_position: Vector2 = _owner.get_viewport().get_mouse_position()
        var origin: = _camera.project_ray_origin(mouse_position)
        var normal: = _camera.project_ray_normal(mouse_position)
        var intersection = plane.intersects_ray(origin, normal)

        if intersection: look_at_point = intersection
    
    return look_at_point


func get_move_direction() -> Vector2:
    var move_direction: = Vector2()
    move_direction.x = Input.get_axis("character.move.left", "character.move.right")
    move_direction.y = Input.get_axis("character.move.up", "character.move.down")
    return move_direction
