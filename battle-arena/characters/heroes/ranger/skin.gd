extends Node3D


@export var body_meshes: Array[MeshInstance3D]
@export var weapon: MeshInstance3D
@export var invisible: Material
@export var charged_weapon: Material


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
    weapon.material_override = charged_weapon
    skill.execution.timeout.connect(func(): weapon.material_override = null, CONNECT_ONE_SHOT)


func play_throw(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func activate_invisibility() -> void:
    for mesh in body_meshes: mesh.material_override = invisible


func deactivate_invisibility() -> void:
    for mesh in body_meshes: mesh.material_override = null
