extends BaseSkill


@export var damage: float
@export var distance: float = 6
@export var radius: float = 2


var target_position: Vector3


func activate(pressed: bool) -> bool:
    if not pressed or not execution.is_stopped(): return false
    return super.activate(pressed)


func _on_activate(pressed: bool) -> void:
    target_position = owner.position + (owner.input.look_at_point - owner.position).limit_length(distance)
    
    super._on_activate(pressed)
    
    owner.transform.basis = Basis.looking_at(owner.position - owner.input.look_at_point)
    owner.rotation.x = 0.0
    owner.rotation.z = 0.0
    
    var time = execution.wait_time
    var tween = create_tween()
    tween.tween_property(owner, "position", target_position + Vector3.UP * 4, time * 0.6) \
        .set_trans(Tween.TRANS_SINE).set_delay(time * 0.2).set_ease(Tween.EASE_OUT)
    tween.tween_property(owner, "position", target_position, time * 0.3).set_trans(Tween.TRANS_EXPO)


func _calculate_target_position() -> void:
    pass


func cancel() -> void:
    pass


func _on_finish() -> void:
    super._on_finish()
    if multiplayer.is_server(): _try_hit_area()


func _try_hit_area() -> void:
    var space_state: PhysicsDirectSpaceState3D = owner.get_world_3d().direct_space_state

    var shape_rid = PhysicsServer3D.sphere_shape_create()
    PhysicsServer3D.shape_set_data(shape_rid, radius)
    
    var params = PhysicsShapeQueryParameters3D.new()
    params.shape_rid = shape_rid
    params.collide_with_bodies = false
    params.collide_with_areas = true
    params.collision_mask = collision_mask
    params.transform = owner.transform
    
    var result: = space_state.intersect_shape(params)
    var hitboxes_count: = 0
    
    for hit in result:
        if hit.collider is HitBox:
            hit.collider.apply_damage.rpc(damage)
            hitboxes_count += 1
    
    if hitboxes_count > 0: gain_energy()
    
    PhysicsServer3D.free_rid(shape_rid)
