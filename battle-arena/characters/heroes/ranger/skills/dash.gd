extends BaseSkill


@export var distance: float = 5
@export var dash_time: float = 0.3


func activate(pressed: bool) -> bool:
    if not pressed or not execution.is_stopped(): return false
    return super.activate(pressed)


func _on_activate(pressed: bool) -> void:
    super._on_activate(pressed)
    
    if not is_multiplayer_authority(): return
    var direction: Vector3 = (owner.transform.basis.z + owner.velocity).normalized()
    var target_position: Vector3 = owner.position + direction * distance
    var tween: = get_tree().create_tween()
    tween.tween_property(owner, "position", target_position, dash_time)
