extends "res://characters/skills/range_attack_skill.gd"


@export var heal: float


var target_position: Vector3


func _ready() -> void:
    super._ready()
    _collision_mask = 0b0001


func _on_activate(pressed: bool) -> void:
    var tween: = get_tree().create_tween()
    tween.tween_method(_update_target_position, 0, execution.wait_time, execution.wait_time)
    super._on_activate(pressed)


func _update_target_position(time: float) -> void:
    target_position = owner.position + (owner.input.look_at_point - owner.position).limit_length(distance)
