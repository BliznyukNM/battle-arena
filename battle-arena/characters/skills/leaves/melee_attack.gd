@tool
extends ActionLeaf


@export var damage: int

@export var hit_range: float = 1.0
@export_range(0, 360, RAYCAST_PER_ANGLE, "degrees") var area: float
@export var offset: = Vector3(0, 0, 0)

@export_flags("Enemy", "Ally") var collision_type: int


const RAYCAST_PER_ANGLE = 5.0
const Utils = preload("res://characters/skills/utils/utils.gd")


var _shape: ConvexPolygonShape3D


func before_run(actor: Node, blackboard: Blackboard) -> void:
    if _shape == null: _setup_shape(actor.owner)


func _setup_shape(character: Node3D) -> void:
    var points: = PackedVector3Array([Vector3.ZERO])
    var forward: Vector3 = Vector3.BACK * hit_range
    
    var angle_step: = 0.0
    while angle_step <= area / 2.0 and angle_step > -180.0 and angle_step <= 180.0:
        points.append(forward.rotated(Vector3.UP, deg_to_rad(angle_step)))
        angle_step = -angle_step + (0.0 if angle_step > 0 else RAYCAST_PER_ANGLE)
    
    _shape = ConvexPolygonShape3D.new()
    _shape.points = points


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    var space_state: PhysicsDirectSpaceState3D = character.get_world_3d().direct_space_state
    
    var params = PhysicsShapeQueryParameters3D.new()
    params.shape_rid = _shape.get_rid()
    params.collide_with_bodies = false
    params.collide_with_areas = true
    params.collision_mask = Utils.get_collision_mask(character, collision_type)
    params.transform = character.transform.translated_local(offset)
    
    var result: = space_state.intersect_shape(params)
    var hitbox_count: = 0
    
    for hit in result:
        if hit.collider is HitBox:
            hit.collider.apply_damage.rpc(damage)
            print("%s receives %d damage" % [hit.collider.owner.name, damage])
            hitbox_count += 1
    
    return SUCCESS if hitbox_count > 0 else FAILURE
