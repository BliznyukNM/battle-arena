class_name HitBox extends Area3D


@export var generate_energy: = true


signal on_damage(source: Character, value: float)
signal on_heal(source: Character, value: float)


var Utils = preload("res://characters/multiplayer/utils.gd")


func _ready() -> void:
    collision_layer = owner.collision_layer


func process_damage(source: Character, damage: float) -> void:
    apply_damage.rpc(damage)
    on_damage.emit(source, damage)


@rpc("reliable", "call_remote")
func apply_damage(value: float) -> void:
    on_damage.emit(null, value)


@rpc("reliable", "call_local")
func apply_heal(value: float) -> void:
    on_heal.emit(null, value)


@rpc("reliable", "call_local")
func apply_modifier(modifier_path: String) -> void:
    if not "modifiers" in owner: return
    Utils.try_add_scene(owner.modifiers.spawner, modifier_path)
    if not is_multiplayer_authority(): return
    owner.modifiers.add_modifier({ "path": modifier_path })
