extends "res://characters/heroes/skin.gd"


func play_basic_attack(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_heal(skill: BaseSkill) -> void:
    animationTree.set("parameters/PlayHeal/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
