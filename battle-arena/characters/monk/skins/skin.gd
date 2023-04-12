extends Node3D


@export var input: PlayerInput
@export var acceleration: float = 5.0
@export var skill_to_animation: Dictionary


@onready var animation: = $AnimationTree


func _ready() -> void:
    assert(input, "Cannot control skin without PlayerInput.")
    
    animation.active = true


func _process(delta: float) -> void:
    var last_direction: Vector2 = animation["parameters/movement/blend_position"]
    var direction: = input.movement.rotated(owner.rotation.y)
    animation["parameters/movement/blend_position"] = lerp(last_direction, direction, delta * acceleration)


func on_skill_activated(skill: BaseSkill) -> void:
    _trigger(skill_to_animation[skill.name])


func _trigger(animation_name: String) -> void:
    animation["parameters/%s/request" % animation_name] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
