extends Node3D


@export var material: Material
@export var invisibility_color: Color


@onready var animationTree: AnimationTree = $AnimationTree


func update_move_direction(direction: Vector2) -> void:
    animationTree.set("parameters/Movement/blend_position", direction)


func update_move_speed(speed: float) -> void:
    animationTree.set("parameters/MoveSpeed/scale", speed)


func update_attack_speed(speed: float) -> void:
    animationTree.set("parameters/AttackSpeed/scale", speed)


func play_shoot(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayShoot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_charge_shot(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayChargeShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func activate_invisibility() -> void:
    material.albedo_color = invisibility_color


func deactivate_invisibility() -> void:
    material.albedo_color = Color.WHITE
