extends Node3D


var direction: Vector2
var is_attacking: bool


@onready var animation: = $AnimationTree


func _ready() -> void:
    animation.active = true


func _process(delta: float) -> void:
    animation["parameters/movement/blend_position"] = direction.length()
