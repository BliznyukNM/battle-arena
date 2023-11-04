extends Area3D


var damage: int
var speed: float
var max_travel_distance: float
var radius: float


var _is_travelling: bool = true
var _travelled_distance: float


@onready var _direction: Vector3 = transform.basis.z
@onready var _collision: CollisionShape3D = $Collision


func _ready() -> void:
    _collision.scale = Vector3.ONE * radius


func _process(delta: float) -> void:
    if not _is_travelling: return
    
    var distance: = speed * delta
    position += _direction * distance
    _travelled_distance += distance
    
    if _travelled_distance >= max_travel_distance:
        _on_finish_travel()


func _on_finish_travel() -> void:
    if not is_multiplayer_authority(): return
    queue_free()


func _on_area_entered(area: Area3D) -> void:
    if not is_multiplayer_authority(): return
    if not area is HitBox: return
    area.apply_damage.rpc(damage)
    var energy_processor = owner.get_node_or_null("%EnergyProcessor")
    if energy_processor: energy_processor.on_damage.rpc(damage)
    _on_finish_travel()
