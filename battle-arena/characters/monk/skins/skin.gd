extends Node3D


@export var input: PlayerInput
@export var acceleration: float = 5.0


@onready var animation: = $AnimationTree


func _ready() -> void:
    animation.active = true


func _process(delta: float) -> void:
    var last_direction: Vector2 = animation["parameters/blend_position"]
    var angle: float = owner.rotation.y
    var direction: = input.movement.rotated(angle)
    animation["parameters/blend_position"] = lerp(last_direction, direction, delta * acceleration)
