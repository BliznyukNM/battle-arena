extends Camera3D


@export var target: Node3D:
    set(value):
        target = value
        if target: position = target.position + offset

@export var lerp_speed: float = 2
@export var offset: Vector3
@export var max_distance: Vector2


func _process(delta: float) -> void:
    if not target: return
    
    var y: = position.y
    var shift: Vector3 = target.input.look_at_point - target.position
    shift.x = clamp(shift.x, -max_distance.x, max_distance.x)
    shift.z = clamp(shift.z, -max_distance.y, max_distance.y)
    position = lerp(position, target.position + shift / 2 + offset, delta * lerp_speed)
    position.y = y
