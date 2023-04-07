extends Node3D


@onready var fireball: = preload("res://characters/dummy/fireball.tscn")


func _on_shoot() -> void:
    if not multiplayer.is_server(): return
    var fireball_instance: = fireball.instantiate()
    fireball_instance.position = global_position + Vector3(0, 1, 1)
    fireball_instance.set_team(0)
    fireball_instance.set_attack_number(0)
    fireball_instance.throw_direction(Vector3.BACK)
    $MultiplayerSpawner.add_child(fireball_instance, true)
