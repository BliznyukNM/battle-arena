extends Node


@onready var animationTree: AnimationTree = $AnimationTree


func update_move_direction(direction: Vector2) -> void:
    animationTree.set("parameters/Movement/blend_position", direction)


func update_move_speed(speed: float) -> void:
    animationTree.set("parameters/MoveSpeed/scale", speed)


func update_attack_speed(speed: float) -> void:
    animationTree.set("parameters/AttackSpeed/scale", speed)
    # slash.speed_scale = speed


func play_spawn() -> void:
    animationTree.set("parameters/PlayDeath/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
    animationTree.set("parameters/PlaySpawn/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_death() -> void:
    animationTree.set("parameters/PlayDeath/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
