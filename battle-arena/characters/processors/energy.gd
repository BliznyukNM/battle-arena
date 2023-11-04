extends Node


@export var energy: NumberStat


const DAMAGE_TO_ENERGY: = 0.5


@rpc("reliable", "call_local")
func on_damage(damage: float) -> void:
    energy.current_value += damage * DAMAGE_TO_ENERGY
