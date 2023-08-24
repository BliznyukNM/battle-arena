extends BaseSkill


@export_range(0, 100, 1, "or_greater") var damage: float

@export var hit_range: float = 1.0
@export_range(0, 360, RAYCAST_PER_ANGLE, "degrees") var area: float
@export var offset: = Vector3(0, 0, 0)

@export var energy_generation: float
@export var energy_stat: NumberStat


var _shape: Shape3D


const RAYCAST_PER_ANGLE = 5.0


func _ready() -> void:
    super._ready()
    if is_multiplayer_authority(): _setup_shape()


func _setup_shape() -> void:
    if is_zero_approx(area):
        _shape = SeparationRayShape3D.new()
        _shape.length = hit_range
        return
    
    var points: = PackedVector3Array([Vector3.ZERO])
    var forward: Vector3 = owner.global_transform.basis.z * hit_range
    var angle_step: = 0.0
        
    while angle_step <= area / 2.0:
        points.append(forward.rotated(Vector3.UP, deg_to_rad(angle_step)))
        points.append(forward.rotated(Vector3.UP, deg_to_rad(-angle_step)))
        angle_step += RAYCAST_PER_ANGLE
        
    _shape = ConvexPolygonShape3D.new()
    _shape.points = points


func activate(pressed: bool) -> void:
    if not pressed: return
    super.activate(pressed)


func _on_execute() -> void:
    await super._on_execute()
    if not is_multiplayer_authority(): return
    _try_hit_shape()


func _try_hit_shape() -> void:
    var space_state: PhysicsDirectSpaceState3D = owner.get_world_3d().direct_space_state
    
    var params = PhysicsShapeQueryParameters3D.new()
    params.shape_rid = _shape.get_rid()
    params.collide_with_bodies = false
    params.collide_with_areas = true
    params.collision_mask = _collision_mask
    params.transform = owner.transform.translated_local(offset)
    
    var result: = space_state.intersect_shape(params)
    var any_hits: = false
    
    for hit in result:
        if hit.collider is HitBox:
            hit.collider.apply_damage.rpc(damage)
            any_hits = true
    
    if any_hits: _on_successful_hit.rpc()


@rpc("reliable", "call_local")
func _on_successful_hit() -> void:
    if energy_stat: energy_stat.current_value += energy_generation
