extends "res://skills/range_attack_skill.gd"


func activate(pressed: bool) -> void:
    if not execution.is_stopped(): return
    super.activate(pressed)


func _spawn_projectile(transform: Transform3D) -> Node:
    var projectile_instance: = super._spawn_projectile(transform)
    projectile_instance.collision_mask = projectile_instance.collision_mask | owner.collision_layer
    owner.on_throw_axe(projectile_instance)
    return projectile_instance
