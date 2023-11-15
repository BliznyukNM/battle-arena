extends "res://characters/skills/range_attack_skill.gd"


@export var max_charge_distance: float
@export var max_charge_damage: float


var _tween: Tween
var _additional_distance: float
var _additional_damage: float


func _get_distance() -> float:
    return distance + _additional_distance
func _get_damage() -> float:
    return damage + _additional_damage


func activate(pressed: bool) -> bool:
    if pressed != execution.is_stopped(): return false
    
    if pressed:
        return super.activate(pressed)
    else:
        _stop_execution()
        return true


func _on_activate(pressed: bool) -> void:
    _additional_damage = 0
    _additional_distance = 0
    _tween = get_tree().create_tween().set_parallel(true)
    _tween.tween_property(self, "_additional_distance", max_charge_distance, execution.base_time)
    _tween.tween_property(self, "_additional_damage", max_charge_damage, execution.base_time)
    super._on_activate(pressed)


func _on_finish() -> void:
    super._on_finish()
    _tween.kill()
