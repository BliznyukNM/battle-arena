extends "res://characters/skin.gd"


func play_shoot() -> void:
    animationTree.set("parameters/PlayAttack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_heal() -> void:
    animationTree.set("parameters/PlayHeal/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
