extends MultiplayerSynchronizer


@export var lerp_amount: float = 5


var server_position: Vector3
var server_rotation: Vector3


var Multiplayer:
    get:
        if not Multiplayer: Multiplayer = Engine.get_singleton("Multiplayer")
        return Multiplayer


func _process(delta: float) -> void:
    if multiplayer.is_server():
        server_position = owner.position
        server_rotation = owner.rotation
    else:
        var target_position: Vector3 = server_position + owner.velocity * Multiplayer.rtt / 2.0
        var distance: = target_position.distance_squared_to(owner.position)
        if distance >= 1.0:
            owner.position = owner.position.move_toward(target_position, min(lerp_amount * distance * delta, 1.0))
        owner.rotation = owner.rotation.move_toward(server_rotation, min(lerp_amount * delta, 1.0))
