class_name HitBox extends Area3D


signal on_damage(value: float)
signal on_heal(value: float)


func _ready() -> void:
    collision_layer = owner.collision_layer


@rpc("reliable", "call_local")
func apply_damage(value: float) -> void:
    on_damage.emit(value)


@rpc("reliable", "call_local")
func apply_heal(value: float) -> void:
    on_heal.emit(value)


@rpc("reliable", "call_local")
func apply_modifier(modifier_path: String) -> void:
    var modifier_scene: = load(modifier_path)
    assert(modifier_scene, "Cannot find %s modifier" % modifier_path)
    var modifier: BaseModifier = modifier_scene.instantiate()
    owner.modifiers.add_modifier(modifier)
