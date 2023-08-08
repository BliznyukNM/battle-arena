extends Node3D


@onready var animationTree: AnimationTree = $AnimationTree

@onready var big_axe: = $"Rig/Skeleton3D/2H_Axe/2H_Axe"
@onready var left_axe: = $"Rig/Skeleton3D/1H_Axe_Offhand/1H_Axe_Offhand"
@onready var right_axe: = $"Rig/Skeleton3D/1H_Axe/1H_Axe"
@onready var mug: = $"Rig/Skeleton3D/Mug/Mug"


func update_stance(stance: String) -> void:
    big_axe.visible = stance == "axe"
    left_axe.visible = stance == "dual"
    right_axe.visible = stance == "dual"
    animationTree.set("parameters/ArmedState/transition_request", stance)


func update_move_direction(direction: Vector2) -> void:
    animationTree.set("parameters/Movement/blend_position", direction)


func update_move_speed(speed: float) -> void:
    animationTree.set("parameters/MoveSpeed/scale", speed)


func update_attack_speed(speed: float) -> void:
    animationTree.set("parameters/AttackSpeed/scale", speed)


func play_slice(skill: BaseSkill) -> void:
    _trigger_attack("slice")


func play_chop(skill: BaseSkill) -> void:
    _trigger_attack("chop")


func play_kick_a(skill: BaseSkill) -> void:
    _trigger_attack("punch_a")


func play_kick_b(skill: BaseSkill) -> void:
    _trigger_attack("punch_b")


func play_dual_chop(skill: BaseSkill) -> void:
    _trigger_attack("dual_chop")


func play_dual_slice(skill: BaseSkill) -> void:
    _trigger_attack("dual_slice")


func stop_attack(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)


func play_taunt(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayTaunt/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    skill.execution.timeout.connect(_stop_taunt, CONNECT_ONE_SHOT)


func _stop_taunt() -> void:
    animationTree.set("parameters/PlayTaunt/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)


func play_spin(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlaySpinning/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    skill.execution.timeout.connect(_stop_spin, CONNECT_ONE_SHOT)


func _stop_spin() -> void:
    animationTree.set("parameters/PlaySpinning/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)


func play_throw(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    skill.execution.timeout.connect(_stop_throw, CONNECT_ONE_SHOT)


func _stop_throw() -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)


func play_drink(skill: BaseSkill) -> void:
    mug.visible = true
    animationTree.set("parameters/PlayDrink/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    skill.execution.timeout.connect(func(): mug.visible = false, CONNECT_ONE_SHOT)


func play_jump(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayJump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func _trigger_attack(attack_name: String) -> void:
    animationTree.set("parameters/AttackType/transition_request", attack_name);
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
