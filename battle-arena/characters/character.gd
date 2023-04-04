class_name Character extends CharacterBody3D


@export var camera: Camera3D
@export var speed: = 1.0
@export var attack_speed: = 1.0


@onready var camera_direction: = Vector3.ZERO if not camera else camera.basis.z.slide(Vector3.UP).normalized()
@onready var animator: = $Animator


var is_attacking: bool:
    get: return Input.is_action_pressed("character.attack.basic");
    
    
func _ready() -> void:
    animator.active = true


func _process(_delta: float) -> void:
    var input: = _get_input()
    velocity = Vector3(input.x, 0.0, input.y)
    var velocity_rotation = Quaternion(Vector3.LEFT, camera_direction)
    velocity = (velocity if velocity.length_squared() < 1 else velocity.normalized()) * velocity_rotation * speed
    move_and_slide()
    
    animator["parameters/Movement/blend_position"] = velocity.length() / speed * 2
    animator["parameters/Attack/speed/scale"] = attack_speed
    animator["parameters/Combo/speed/scale"] = attack_speed
    
    if not camera: return
    
    var mouse_position: = get_viewport().get_mouse_position()
    var origin: = camera.project_ray_origin(mouse_position)
    var normal: = camera.project_ray_normal(mouse_position)
    var plane: = Plane(Vector3.UP)
    var intersection = plane.intersects_ray(origin, normal)
    
    if intersection:
        look_at(intersection)
        rotation_degrees.x = 0.0


func _get_input() -> Vector2:
    var input: = Vector2()
    input.y = Input.get_axis("character.move.down", "character.move.up")
    input.x = Input.get_axis("character.move.right", "character.move.left")
    return input
