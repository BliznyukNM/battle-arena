class_name PlayerInput extends MultiplayerSynchronizer


signal basic_attack(pressed: bool)
signal secondary_attack(pressed: bool)


@export var movement: Vector2
@export var look_at_point: Vector3 = Vector3(1, 1, 1)


func _ready() -> void:
    set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


func _process(_delta: float) -> void:
    movement = Input.get_vector("character.move.left", "character.move.right", \
        "character.move.up", "character.move.down")
        
    var camera: = get_viewport().get_camera_3d()
    if camera:
        var mouse_position: = get_viewport().get_mouse_position()
        var origin: = camera.project_ray_origin(mouse_position)
        var normal: = camera.project_ray_normal(mouse_position)
        var plane: = Plane(Vector3.UP)
        var intersection = plane.intersects_ray(origin, normal)

        if intersection: look_at_point = intersection
    
    if Input.is_action_just_pressed("character.attack.basic"):
        _on_action_changed.rpc("basic_attack", true)
    elif Input.is_action_just_released("character.attack.basic"):
        _on_action_changed.rpc("basic_attack", false)
    
    if Input.is_action_just_pressed("character.attack.strong"):
        _on_action_changed.rpc("secondary_attack", true)
    elif Input.is_action_just_released("character.attack.strong"):
        _on_action_changed.rpc("secondary_attack", false)


@rpc("reliable", "call_local")
func _on_action_changed(action: String, enabled: bool) -> void:
    emit_signal(action, enabled)
