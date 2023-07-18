extends "res://skills/base_skill.gd"


@export var damage: int
@export var hit_time: float

@export var hit_range: float = 1.0
@export_range(0, 360, RAYCAST_PER_ANGLE, "degrees") var area: float
@export var offset: = Vector3(0, 0, 0)


var _shape: ConvexPolygonShape3D


const RAYCAST_PER_ANGLE = 5.0


func _ready() -> void:
    var points: = PackedVector3Array([Vector3.ZERO])
    var forward: Vector3 = owner.global_transform.basis.z * hit_range
    
    var angle_step: = 0.0
    while angle_step <= area / 2.0 and angle_step > -180.0 and angle_step <= 180.0:
        points.append(forward.rotated(Vector3.UP, deg_to_rad(angle_step)))
        angle_step = -angle_step + (0.0 if angle_step > 0 else RAYCAST_PER_ANGLE)
    
    _shape = ConvexPolygonShape3D.new()
    _shape.points = points


func _on_activate() -> void:
    super._on_activate()
    
    var tween: = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
    tween.tween_callback(_try_hit_shape).set_delay(hit_time)


func _try_hit_shape() -> void:
    var space_state: PhysicsDirectSpaceState3D = owner.get_world_3d().direct_space_state
    
    var params = PhysicsShapeQueryParameters3D.new()
    params.shape_rid = _shape.get_rid()
    params.collide_with_bodies = false
    params.collide_with_areas = true
    params.collision_mask = _collision_mask
    params.transform = owner.transform.translated(offset)
    
    var result: = space_state.intersect_shape(params)
    
    for hit in result:
        hit.collider.on_damage.emit(damage)
