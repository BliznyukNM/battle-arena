extends Node


@export var rotation_speed: NumberStat


var Multiplayer:
    get:
        if not Multiplayer: Multiplayer = Engine.get_singleton("Multiplayer")
        return Multiplayer


func _process(delta: float) -> void:
    if owner.input.look_at_point == Vector3.ZERO: return
    
    var stun_modifier: bool = owner.modifiers.has_modifier("Stun")
    if stun_modifier: return
    
    var new_basis: Basis = Basis.looking_at(owner.position - owner.input.look_at_point)
    
    var weight = rotation_speed.current_value
    
    if not multiplayer.is_server():
        var old_rotation: Quaternion = owner.transform.basis.get_rotation_quaternion()
        var new_rotation: = new_basis.get_rotation_quaternion()
        var angle: = deg_to_rad(new_rotation.angle_to(old_rotation))
        new_rotation = old_rotation.slerp(new_rotation, 1 + angle * (1 + Multiplayer.rtt))
        new_basis = Basis(new_rotation)
    
    owner.transform.basis = lerp(owner.transform.basis, new_basis, clampf(weight * delta, 0.0, 1.0)).orthonormalized()
    
    owner.rotation.x = 0.0
    owner.rotation.z = 0.0
