extends Node


@export var energy: NumberStat


const ON_HIT_ENERGY: = 5


func on_damage(damage: float) -> void:
    energy.current_value += ON_HIT_ENERGY
