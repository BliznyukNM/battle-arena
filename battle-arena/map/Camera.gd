extends Camera3D


@export var target: Node3D:
    set(value):
        target = value
        if target: position = target.position + offset

@export var lerp_speed: float = 2
@export var offset: Vector3
@export var max_distance: float = 30


@onready var input: PlayerInput = target.get_node("Input")


func _process(delta: float) -> void:
    if not target: return
    
    var shift: = (input.look_at_point - target.position).limit_length(max_distance)
    position = lerp(position, target.position + shift / 2 + offset, delta * lerp_speed)
