extends "res://characters/skills/base_skill.gd"


@export var spawn_point: Vector3
@export var damage: float
@export var projectile_speed: float
@export var distance: float
@export var radius: float


@onready var container: MultiplayerSpawner = $Container


func _ready() -> void:
    super._ready()
    container.spawn_function = _spawn_projectile
    container.spawned.connect(_on_spawn_projectile)


func activate(pressed: bool) -> void:
    if not pressed: return
    super.activate(pressed)


func finish() -> void:
    super.finish()
    
    if not is_multiplayer_authority(): return
    
    var projectile: = container.spawn(owner.transform.translated_local(spawn_point))
    _on_spawn_projectile(projectile)


func _on_spawn_projectile(projectile: Node) -> void:
    projectile.owner = owner


func _spawn_projectile(transform: Transform3D) -> Node:
    var scene: = load(container.get_spawnable_scene(0))
    var projectile_instance: CollisionObject3D = scene.instantiate()
    projectile_instance.collision_mask = _collision_mask
    projectile_instance.collision_layer = owner.collision_layer
    projectile_instance.transform = transform
    
    projectile_instance.damage = damage
    projectile_instance.speed = projectile_speed
    projectile_instance.max_travel_distance = distance - spawn_point.z
    projectile_instance.radius = radius
    
    return projectile_instance
