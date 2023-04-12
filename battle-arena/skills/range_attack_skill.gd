extends "res://skills/base_skill.gd"


@export var projectile: PackedScene
@export var spawn_delay: float


@onready var spawn_point: = $SpawnPosition
@onready var container: = $Container


func _on_pressed() -> void:
    super._on_pressed()
    var tween: = create_tween()
    tween.tween_callback(self._shoot).set_delay(spawn_delay)


func _shoot() -> void:
    var projectile_instance: Area3D = projectile.instantiate()
    projectile_instance.position = spawn_point.global_position
    projectile_instance.rotate_y(owner.rotation.y)
    projectile_instance.shoot(owner.transform.basis.z)
    projectile_instance.collision_mask = collision_mask
    container.add_child(projectile_instance)
