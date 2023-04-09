extends Node3D


var direction: Vector2


@onready var animation: = $AnimationTree


func _ready() -> void:
    animation.active = true


func _process(delta: float) -> void:
     animation["parameters/blend_position"] = direction
