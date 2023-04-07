class_name Character extends CharacterBody3D


enum Team { None = 0, TeamA = 1, TeamB = 2 }


@export var health: = 100
@export var speed: = 1.0
@export var evade_speed: = 5.0
@export var attack_speed: = 1.0

@export var player_id: int:
    set(value):
        player_id = value
        $Input.set_multiplayer_authority(player_id)

@export var team: Team:
    set(value):
        team = value
        collision_layer = 1 << value
        $HitBox.collision_layer = 1 << value


@onready var animator: = $Animator
@onready var input: = $Input
@onready var spawner: = $Spawner
@onready var right_hand: = $"View/KayKit Animated Character2/Skeleton3D/HandlSlotRight"


@onready var cup: = preload("res://characters/monk/cup_throwable.tscn")


var current_health: float:
    set(value):
        current_health = value
        if current_health <= 0.0 and multiplayer.is_server():
            queue_free()


var is_attacking: bool:
    get: return input.is_attacking


var _evading_direction: Vector3:
    set(value):
        _evading_direction = value
        animator["parameters/conditions/is_evading"] = value.length_squared() > 0


var is_local: bool:
    get: return player_id == multiplayer.get_unique_id()
    
    
func _ready() -> void:
    animator.active = true
    current_health = health


func _process(delta: float) -> void:
    if _evading_direction.length_squared() > 0:
        velocity = _evading_direction * evade_speed
    else:
        var movement: Vector2 = input.movement
        velocity = Vector3(movement.x, 0.0, movement.y)
        if velocity.length_squared() > 1: velocity = velocity.normalized()
        animator["parameters/Movement/blend_position"] = velocity.length() * 2
        velocity *= speed

        animator["parameters/Attack/speed/scale"] = attack_speed
        animator["parameters/Combo/speed/scale"] = attack_speed
        
        var new_basis: = transform.basis.looking_at(input.look_at_point - position)
        transform.basis = lerp(transform.basis, new_basis, delta * 10)
    
    move_and_slide()


func _throw() -> void:
    if not multiplayer.is_server(): return
    
    var cup_instance: Node3D = cup.instantiate()
    cup_instance.position = right_hand.global_position
    cup_instance.set_team(team)
    cup_instance.set_attack_number(0)
    cup_instance.throw(input.look_at_point)
    spawner.add_child(cup_instance, true)


func _roll() -> void:
    if not multiplayer.is_server(): return
    
    _evading_direction = -transform.basis.z
    await animator.animation_finished
    _evading_direction = Vector3.ZERO


func _execute_secondary_attack() -> void:
    animator["parameters/conditions/is_throwing"] = true
    await get_tree().create_timer(0.1).timeout
    animator["parameters/conditions/is_throwing"] = false


func _execute_evade() -> void:
    animator["parameters/conditions/is_evading"] = true
    await get_tree().create_timer(0.1).timeout
    animator["parameters/conditions/is_evading"] = false


func _apply_damage(damage: float) -> void:
    current_health -= damage
