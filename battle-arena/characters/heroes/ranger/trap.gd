extends Area3D


@export var lifetime: float = 5
@export var damage: int
@export var modifier: PackedScene


func _ready() -> void:
    collision_layer = owner.collision_layer
    collision_mask = owner.collision_mask ^ owner.collision_layer
    
    var tween: = get_tree().create_tween()
    tween.tween_callback(func(): queue_free()).set_delay(lifetime)


func init(options: Dictionary) -> void:
    pass


func _on_area_entered(area: Area3D) -> void:
    if not is_multiplayer_authority(): return
    if not area is HitBox: return
    
    area.apply_modifier.rpc(modifier.resource_path)
    area.process_damage(owner, damage)
    
    queue_free()
