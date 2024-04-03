extends MultiplayerSynchronizer


@export var lerp_amount: float = 5


var server_transform: Transform3D


var Multiplayer:
    get:
        if not Multiplayer: Multiplayer = Engine.get_singleton("Multiplayer")
        return Multiplayer


func _process(delta: float) -> void:
    if multiplayer.is_server():
        server_transform = owner.transform
    else:
        const epsilon_distance: = 0.5
        var distance_sqr: float = server_transform.origin.distance_squared_to(owner.transform.origin) - epsilon_distance
        #if distance_sqr > 4.0: owner.transform = server_transform
        owner.transform = owner.transform.interpolate_with(server_transform, clamp(distance_sqr * (1 + Multiplayer.rtt) * delta, 0.0, 1.0))
