extends Node


@onready var animationTree: AnimationTree = $AnimationTree


func play_spawn() -> void:
    animationTree.set("parameters/PlayDeath/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
    animationTree.set("parameters/PlaySpawn/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_death() -> void:
    animationTree.set("parameters/PlayDeath/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
