extends "res://skills/base_skill.gd"


@export var projectile: PackedScene
@export var spawn_point: Vector3


@onready var container: = $Container


func _ready() -> void:
    super._ready()
    execution.timeout.connect(_shoot)


func _shoot() -> void:
    var projectile_instance: CollisionObject3D = projectile.instantiate()
    projectile_instance.transform = owner.transform.translated_local(spawn_point)
    projectile_instance.collision_mask = _collision_mask
    projectile_instance.shoot(owner.transform.basis.z)
    container.add_child(projectile_instance)
