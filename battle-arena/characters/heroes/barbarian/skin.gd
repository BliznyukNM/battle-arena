extends "res://characters/skin.gd"


@export var taunt: Material
@export var charged_2h_axe: Material

@onready var slash: GPUParticles3D = $Slash/SlashParticles

@onready var big_axe: = $"Rig/Skeleton3D/2H_Axe/2H_Axe"
@onready var left_axe: = $"Rig/Skeleton3D/1H_Axe_Offhand/1H_Axe_Offhand"
@onready var right_axe: = $"Rig/Skeleton3D/1H_Axe/1H_Axe"
@onready var mug: = $"Rig/Skeleton3D/Mug/Mug"
@onready var body_meshes: Array[MeshInstance3D] = [
    $Rig/Skeleton3D/Barbarian_ArmLeft,
    $Rig/Skeleton3D/Barbarian_ArmRight,
    $Rig/Skeleton3D/Barbarian_Body,
    $Rig/Skeleton3D/Barbarian_Head,
    $Rig/Skeleton3D/Barbarian_LegLeft,
    $Rig/Skeleton3D/Barbarian_LegRight,
    $Rig/Skeleton3D/Barbarian_Hat/Barbarian_Hat,
    $Rig/Skeleton3D/Barbarian_Cape/Barbarian_Cape,
]


## Update stance of Barbarian
## Type of stances: axe, dual, hands
func update_stance(stance: String) -> void:
    big_axe.visible = stance == "axe"
    left_axe.visible = stance == "dual"
    right_axe.visible = stance == "dual"
    animationTree.set("parameters/ArmedState/transition_request", stance)


func play_slice() -> void:
    _trigger_attack("slice")


func play_chop() -> void:
    _trigger_attack("chop")


func play_kick_a() -> void:
    _trigger_attack("punch_a")


func play_kick_b() -> void:
    _trigger_attack("punch_b")


func play_dual_chop() -> void:
    _trigger_attack("dual_chop")


func play_dual_slice() -> void:
    _trigger_attack("dual_slice")


func stop_attack(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)


func play_taunt() -> void:
    animationTree.set("parameters/PlayTaunt/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    for mesh in body_meshes: mesh.material_override = taunt
    # skill.execution.timeout.connect(_stop_taunt, CONNECT_ONE_SHOT)


func stop_taunt() -> void:
    animationTree.set("parameters/PlayTaunt/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
    for mesh in body_meshes: mesh.material_override = null


func play_rage() -> void:
    big_axe.material_override = charged_2h_axe


func stop_rage() -> void:
    big_axe.material_override = null


func play_spin() -> void:
    animationTree.set("parameters/PlaySpinning/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func stop_spin() -> void:
    animationTree.set("parameters/PlaySpinning/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)


func play_throw() -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func stop_throw() -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)


func play_drink() -> void:
    mug.visible = true
    animationTree.set("parameters/PlayDrink/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    animationTree.animation_finished.connect(func(anim): mug.visible = false, CONNECT_ONE_SHOT)


func play_jump() -> void:
    animationTree.set("parameters/PlayJump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func _trigger_attack(attack_name: String) -> void:
    animationTree.set("parameters/AttackType/transition_request", attack_name);
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
