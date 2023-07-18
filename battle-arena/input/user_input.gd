class_name UserInput extends InputProvider


var _camera: Camera3D:
    get:
        if _camera == null: _camera = get_viewport().get_camera_3d()
        return _camera


func _process(delta: float) -> void:
    move_direction.x = Input.get_axis("character.move.left", "character.move.right")
    move_direction.y = Input.get_axis("character.move.up", "character.move.down")
    
    if _camera:
        var plane: = Plane(Vector3.UP)
        var mouse_position: = get_viewport().get_mouse_position()
        var origin: = _camera.project_ray_origin(mouse_position)
        var normal: = _camera.project_ray_normal(mouse_position)
        var intersection = plane.intersects_ray(origin, normal)

        if intersection: look_at_point = intersection
    
    _process_actions("character.attack.basic", "on_basic_attack")
    _process_actions("character.attack.strong", "on_secondary_attack")


func _process_actions(action: String, signal_name: String) -> void:
    if Input.is_action_just_pressed(action):
        _on_action_triggered.rpc(signal_name, true)
    elif Input.is_action_just_released(action):
        _on_action_triggered.rpc(signal_name, false)


@rpc("reliable", "call_local")
func _on_action_triggered(signal_name: String, pressed: bool) -> void:
    emit_signal(signal_name, pressed)
