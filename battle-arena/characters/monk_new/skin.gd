extends Node3D


@export var input: PlayerInput


@onready var animation: = $AnimationTree


func _ready() -> void:
    animation.active = true


func _process(delta: float) -> void:
    var angle: float = owner.rotation.y
    var animation_direction: = input.movement.rotated(angle)
    animation_direction.x *= -1
    animation["parameters/blend_position"] = animation_direction
