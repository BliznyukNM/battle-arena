extends Node3D


@export var barbarian: Node


func _ready() -> void:
    barbarian.input.input_source = load("res://input/user_input.gd").new()
    $GUI.target = barbarian
