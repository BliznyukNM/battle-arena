extends Camera3D


@export var lerp_speed: float = 2
@export var offset: Vector3
@export var target: Node3D:
    set(value):
        target = value
        if target: position = target.position + offset


func _process(delta: float) -> void:
    if not target: return
    position = lerp(position, target.position + offset, delta * lerp_speed)
