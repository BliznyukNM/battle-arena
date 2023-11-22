extends Area3D


var skill: BaseSkill


var _is_travelling: bool = true
var _travelled_distance: float


@onready var _collision: CollisionShape3D = $Collision


func _ready() -> void:
    _collision.scale = Vector3.ONE * skill.radius


func _process(delta: float) -> void:
    if not _is_travelling: return
    
    var distance: float = skill.projectile_speed * delta
    position += transform.basis.z * distance
    _travelled_distance += distance
    
    if _travelled_distance >= skill.distance:
        _on_finish_travel()


func _on_finish_travel() -> void:
    if not is_multiplayer_authority(): return
    queue_free()


func _on_area_entered(area: Area3D) -> void:
    if not is_multiplayer_authority(): return
    if not area is HitBox: return
    area.apply_damage.rpc(skill.damage)
    skill.gain_energy.rpc()
    _on_finish_travel()
