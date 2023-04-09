extends Node3D


@export var input: PlayerInput


@onready var animation: = $AnimationTree


func _ready() -> void:
    animation.active = true


func _process(delta: float) -> void:
     animation["parameters/blend_position"] = input.movement
