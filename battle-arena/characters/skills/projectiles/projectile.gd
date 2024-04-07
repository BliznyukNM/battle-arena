extends Area3D


@export var radius: float
@export var speed: float
@export var distance: float
@export var damage: int
@export_range(0, 100, 1) var energy_gain: int


var _is_travelling: bool = true
var _travelled_distance: float


@onready var _collision: CollisionShape3D = $Collision


func _ready() -> void:
    _collision.scale = Vector3.ONE * radius # TODO: * skill.radius
    collision_layer = owner.collision_layer
    collision_mask = owner.collision_mask ^ owner.collision_layer


func _process(delta: float) -> void:
    if not _is_travelling: return
    
    var frame_distance: float = speed * delta # TODO: skill.projectile_speed * delta
    position += transform.basis.z * frame_distance
    _travelled_distance += frame_distance
    
    if _travelled_distance >= distance: # TODO: skill.distance:
        _on_finish_travel()


func _on_finish_travel() -> void:
    if not is_multiplayer_authority(): return
    queue_free()


func _on_area_entered(area: Area3D) -> void:
    if not is_multiplayer_authority(): return
    if not area is HitBox: return
    if not is_zero_approx(damage): area.apply_damage.rpc(damage)
    if not is_zero_approx(energy_gain): owner.gain_energy.rpc(energy_gain)
    _on_finish_travel()
