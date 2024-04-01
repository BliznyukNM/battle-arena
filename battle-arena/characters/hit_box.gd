class_name HitBox extends Area3D


signal on_damage(value: float)
signal on_heal(value: float)


var Utils = preload("res://characters/multiplayer/utils.gd")


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
    Utils.try_add_scene(owner.modifiers.spawner, modifier_path)
    if not is_multiplayer_authority(): return
    owner.modifiers.add_modifier({ "path": modifier_path })
