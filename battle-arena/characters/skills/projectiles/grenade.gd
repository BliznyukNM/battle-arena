extends Area3D


@export var height: Curve


var skill: BaseSkill


var _start_position: Vector3
var _target_position: Vector3
var _time_to_reach: float
var _time_passed: float


func _ready() -> void:
    owner = skill.owner
    _start_position = position
    _target_position = skill.target_position
    _time_to_reach = (_target_position - position).length() / skill.projectile_speed


func _process(delta: float) -> void:
    _time_passed += delta
    position = _start_position.lerp(_target_position, ease(_time_passed / _time_to_reach, 0.45))
    position.y = _start_position.y * height.sample(_time_passed / _time_to_reach)
    
    if _time_passed >= _time_to_reach and is_multiplayer_authority(): _on_finish_travel()


func _on_body_entered(body: Node3D) -> void:
    if not is_multiplayer_authority(): return
    if body.has_node("HitBox"): return # FIXME
    _on_finish_travel()


func _on_finish_travel() -> void:
    var space_state: PhysicsDirectSpaceState3D = owner.get_world_3d().direct_space_state
        
    var shape_rid = PhysicsServer3D.sphere_shape_create()
    PhysicsServer3D.shape_set_data(shape_rid, skill.radius)
    
    var params = PhysicsShapeQueryParameters3D.new()
    params.shape_rid = shape_rid
    params.collide_with_bodies = false
    params.collide_with_areas = true
    params.collision_mask = skill.collision_mask
    params.transform = global_transform
    
    var result: = space_state.intersect_shape(params)
    var hitbox_count: = 0
    
    for hit in result:
        if hit.collider != self and hit.collider is HitBox:
            if _process_hit(hit.collider): hitbox_count += 1
    
    if hitbox_count > 0: skill.gain_energy()
    PhysicsServer3D.free_rid(shape_rid)
    queue_free()


func _process_hit(hitbox: HitBox) -> bool: return false
