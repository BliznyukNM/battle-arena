extends Area3D


@export var lifetime: float = 5
@export var modifier: PackedScene


var damage: float


# TODO: add timeout
func _ready() -> void:
    var tween: = get_tree().create_tween()
    tween.tween_callback(func(): queue_free()).set_delay(lifetime)


func _on_area_entered(area: Area3D) -> void:
    if not is_multiplayer_authority(): return
    if not area is HitBox: return
    
    area.apply_modifier.rpc(modifier.resource_path)
    area.apply_damage.rpc(damage)
    
    queue_free()
