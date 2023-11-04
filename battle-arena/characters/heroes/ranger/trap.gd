extends Area3D


@export var modifier: PackedScene


var damage: float


# TODO: add timeout


func _on_area_entered(area: Area3D) -> void:
    if not is_multiplayer_authority(): return
    if not area is HitBox: return
    
    area.apply_modifier.rpc(modifier.resource_path)
    area.apply_damage.rpc(damage)
    
    queue_free()
