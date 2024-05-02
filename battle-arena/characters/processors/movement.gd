extends Node


@export var movement_speed: NumberStat


var Multiplayer:
    get:
        if not Multiplayer: Multiplayer = Engine.get_singleton("Multiplayer")
        return Multiplayer


func _process(delta: float) -> void:
    var root_modifier: bool = owner.modifiers.has_modifier("Root")
    var stun_modifier: bool = owner.modifiers.has_modifier("Stun")
    
    if root_modifier or stun_modifier:
        owner.velocity = Vector3.ZERO
        return
    
    var movement: Vector2 = owner.input.move_direction
    
    if is_multiplayer_authority(): movement *= 1 + Multiplayer.rtt
    
    var velocity: = Vector3(movement.x, 0.0, movement.y)
    if velocity.length_squared() > 1: velocity = velocity.normalized()
    velocity *= movement_speed.current_value
    
    owner.velocity = velocity
    owner.move_and_slide()
