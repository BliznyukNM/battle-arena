extends Node


@export var delay: = 1.0


func respawn() -> void:
    await get_tree().create_timer(delay).timeout
    owner.reset()
