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


func trigger_attack(skill: BaseSkill) -> void:
    animationTree.set("parameters/AttackType/transition_request", skill.name);
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


"""
func trigger_jump() -> void:
    animationTree.set("parameters/PlayJump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func trigger_spin() -> void:
    animationTree.set("parameters/PlaySpin/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
"""
