extends "res://characters/projectile.gd"


@onready var animation: AnimationPlayer = $AnimationPlayer


var _is_recalling: bool


func _ready() -> void:
    animation.play("rotating", -1, 2.0)


func recall() -> void:
    _is_recalling = true
    _is_travelling = false
    animation.play("rotating", -1, -2.0)


func _process(delta: float) -> void:
    super._process(delta)
    
    if not _is_recalling: return
    var distance: = speed * delta
    var direction: Vector3 = (owner.global_position - position).normalized()
    position += direction * distance


func _on_finish_travel() -> void:
    _is_travelling = false
    animation.play("floor_stuck")


func _on_area_entered(area: Area3D) -> void:
    if not is_multiplayer_authority(): return
    
    if _is_travelling or _is_recalling:
        if area.collision_layer != collision_layer and area is HitBox:
            area.apply_damage.rpc(damage)
    if area is HitBox and area.owner == owner:
        owner.on_pickup_axe.rpc()


func _on_obstacle_hit(obstacle: Node3D) -> void:
    if not _is_travelling: return
    if obstacle.has_node("HitBox"): return
    _is_travelling = false
    animation.play("obstacle_stuck")
