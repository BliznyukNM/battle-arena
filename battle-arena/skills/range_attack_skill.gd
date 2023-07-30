extends "res://skills/base_skill.gd"


@export var projectile: PackedScene
@export var spawn_point: Vector3


@onready var container: = $Container


func activate(pressed: bool) -> void:
    if not pressed: return
    super.activate(pressed)


func finish() -> void:
    super.finish()
    if is_multiplayer_authority(): _shoot.rpc(owner.transform.translated_local(spawn_point))


func _get_projectile() -> CollisionObject3D:
    var projectile_instance: CollisionObject3D = projectile.instantiate()
    projectile_instance.collision_mask = _collision_mask
    projectile_instance.collision_layer = owner.collision_layer
    return projectile_instance


@rpc("reliable", "call_local")
func _shoot(transform: Transform3D) -> void:
    var projectile_instance: = _get_projectile()
    projectile_instance.transform = transform
    _on_shoot(projectile_instance)


func _on_shoot(projectile_instance: CollisionObject3D) -> void:
    container.add_child(projectile_instance)
    projectile_instance.owner = owner
    projectile_instance.shoot(projectile_instance.transform.basis.z)
