extends Area3D


@export var value: float


func _on_pickup(body: Node3D) -> void:
    if not is_multiplayer_authority(): return
    if not body is Character: return
    
    var energy_stat: NumberStat = body.stats.get_stat("Energy")
    if not energy_stat: return
    
    energy_stat.apply_changes.rpc(0.0, 0.0, value)
