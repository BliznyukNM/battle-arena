extends "res://skills/range_attack_skill.gd"


func activate(pressed: bool) -> void:
    if not execution.is_stopped(): return
    super.activate(pressed)


func _get_projectile() -> CollisionObject3D:
    var projectile_instance: = super._get_projectile()
    projectile_instance.collision_mask = projectile_instance.collision_mask | owner.collision_layer
    return projectile_instance


func _on_shoot(projectile_instance: CollisionObject3D) -> void:
    super._on_shoot(projectile_instance)
    owner.on_throw_axe(projectile_instance)
