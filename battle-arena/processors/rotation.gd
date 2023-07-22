extends Node


@export var rotation_speed: NumberStat


func _process(delta: float) -> void:
    var new_basis: Basis = Basis.looking_at(owner.position - owner.input.look_at_point)
    var weight = delta * rotation_speed.current_value
    owner.transform.basis = lerp(owner.transform.basis, new_basis, clampf(weight, 0, 1))
    
    owner.rotation.x = 0.0
    owner.rotation.z = 0.0
