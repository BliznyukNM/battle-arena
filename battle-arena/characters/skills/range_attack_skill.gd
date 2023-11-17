extends BaseSkill


@export var spawn_point: Vector3
@export var damage: float:
    get = _get_damage
@export var projectile_speed: float
@export var distance: float:
    get = _get_distance
@export var radius: float


@onready var container: MultiplayerSpawner = $Container


func _get_distance() -> float:
    return distance
func _get_damage() -> float:
    return damage


func _ready() -> void:
    super._ready()
    container.spawn_function = _spawn_projectile
    container.spawned.connect(_on_spawn_projectile)


func activate(pressed: bool) -> bool:
    if not pressed or not execution.is_stopped(): return false
    return super.activate(pressed)


func finish() -> void:
    super.finish()
    
    if not is_multiplayer_authority(): return
    
    var projectile_transform: Transform3D = owner.transform.translated_local(spawn_point)
    var projectile: = container.spawn(projectile_transform)
    _on_spawn_projectile(projectile)


func _on_spawn_projectile(projectile: Node) -> void:
    projectile.owner = owner


func _spawn_projectile(transform: Transform3D) -> Node:
    var scene: = load(container.get_spawnable_scene(0))
    var projectile_instance: CollisionObject3D = scene.instantiate()
    projectile_instance.collision_mask = _collision_mask
    projectile_instance.collision_layer = owner.collision_layer
    projectile_instance.transform = transform
    projectile_instance.skill = self
    
    return projectile_instance
