extends "res://characters/skills/range_attack_skill.gd"


var target_position: Vector3


func _on_activate(pressed: bool) -> void:
    var tween: = get_tree().create_tween()
    tween.tween_method(_update_target_position, 0, execution.wait_time, execution.wait_time)
    super._on_activate(pressed)


func _update_target_position(time: float) -> void:
    target_position = owner.position + (owner.input.look_at_point - owner.position).limit_length(distance)


func _spawn_projectile(transform: Transform3D) -> Node:
    var scene: = load(container.get_spawnable_scene(0))
    var projectile_instance: CollisionObject3D = scene.instantiate()
    projectile_instance.collision_mask = _collision_mask
    projectile_instance.collision_layer = owner.collision_layer
    projectile_instance.transform = Transform3D(Basis.IDENTITY, target_position)
    projectile_instance.skill = self
    return projectile_instance
