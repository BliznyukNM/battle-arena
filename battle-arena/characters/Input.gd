extends MultiplayerSynchronizer


signal secondary_attack
signal evade


@export var is_attacking: bool
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
    
    is_attacking = Input.is_action_pressed("character.attack.basic")
    
    if Input.is_action_just_pressed("character.attack.strong"):
        _execute_secondary_attack.rpc()
    
    if Input.is_action_just_pressed("character.move.evade"):
        _execute_evade.rpc()


@rpc("call_local", "reliable")
func _execute_secondary_attack() -> void:
    secondary_attack.emit()


@rpc("call_local", "reliable")
func _execute_evade() -> void:
    evade.emit()
