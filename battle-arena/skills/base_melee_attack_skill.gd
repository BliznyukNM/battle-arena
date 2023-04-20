extends "res://skills/base_skill.gd"


@export var damage: int
@export var hit_time: float

@export var hit_range: float = 1.0
@export_range(0, 360, RAYCAST_PER_ANGLE, "degrees") var area: float


const RAYCAST_PER_ANGLE = 5.0


func _on_activate() -> void:
    super._on_activate()
    
    var tween: = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
    tween.tween_callback(self._try_hit).set_delay(hit_time)


func _try_hit() -> void:
    var space_state: PhysicsDirectSpaceState3D = owner.get_world_3d().direct_space_state
    var angle_step: = 0.0
    
    var origin: Vector3 = owner.global_position + Vector3.UP
    var forward: Vector3 = owner.global_transform.basis.z
    
    while angle_step <= area / 2.0 and angle_step > -180.0 and angle_step <= 180.0:
        var rotated_forward: = forward.rotated(Vector3.UP, deg_to_rad(angle_step))
        var raycast: = PhysicsRayQueryParameters3D.create(origin, origin + rotated_forward * hit_range, _collision_mask)
        raycast.collide_with_bodies = false
        raycast.collide_with_areas = true
        var result: = space_state.intersect_ray(raycast)
        
        angle_step = -angle_step + (0.0 if angle_step > 0 else RAYCAST_PER_ANGLE)
        
        if result.is_empty(): continue
        if not result.collider is HitBox: continue
        
        result.collider.on_hit.emit(damage)
        break
