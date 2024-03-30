extends Node3D


@export var body_meshes: Array[MeshInstance3D]
@export var weapon: MeshInstance3D
@export var invisible: Material
@export var charged_weapon: Material
@export var ultimate: Material


@onready var animationTree: AnimationTree = $AnimationTree


func update_move_direction(direction: Vector2) -> void:
    animationTree.set("parameters/Movement/blend_position", direction)


func update_move_speed(speed: float) -> void:
    animationTree.set("parameters/MoveSpeed/scale", speed)


func update_attack_speed(speed: float) -> void:
    animationTree.set("parameters/AttackSpeed/scale", speed)


func play_shoot() -> void:
    animationTree.set("parameters/PlayShoot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_charge_shot() -> void:
    animationTree.set("parameters/PlayChargeShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    weapon.material_override = charged_weapon
    # skill.execution.timeout.connect(func(): weapon.material_override = null, CONNECT_ONE_SHOT)


func play_throw() -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_ultimate() -> void:
    # animationTree.set("parameters/UltimateTimeScale/scale", 0.8 / skill.execution.base_time)
    animationTree.set("parameters/PlayUltimate/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    for mesh in body_meshes: mesh.material_override = ultimate
    # skill.execution.timeout.connect(func(): for mesh in body_meshes: mesh.material_override = null, \
    #    CONNECT_ONE_SHOT)


func play_invisibility() -> void:
    for mesh in body_meshes: mesh.material_override = invisible


func stop_invisibility() -> void:
    for mesh in body_meshes: mesh.material_override = null
