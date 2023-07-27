extends Node3D


@onready var animationTree: AnimationTree = $AnimationTree
@onready var axe: = $"Rig/Skeleton3D/2H_Axe/2H_Axe"


func update_stance(stance: String) -> void:
    axe.visible = stance == "axe"
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


func stop_attack(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)


func play_taunt(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayTaunt/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    skill.execution.timeout.connect(_stop_taunt, CONNECT_ONE_SHOT)


func _stop_taunt() -> void:
    animationTree.set("parameters/PlayTaunt/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)


func play_throw(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
    skill.execution.timeout.connect(_stop_throw, CONNECT_ONE_SHOT)


func _stop_throw() -> void:
    animationTree.set("parameters/PlayThrow/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)


func _trigger_attack(attack_name: String) -> void:
    animationTree.set("parameters/AttackType/transition_request", attack_name);
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


"""
func trigger_jump() -> void:
    animationTree.set("parameters/PlayJump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func trigger_spin() -> void:
    animationTree.set("parameters/PlaySpin/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
"""
