extends Node


@export var energy_amount: int


signal picked_up


func apply_bonuses(character: Character) -> void:
    var energy_stat: NumberStat = character.stats.get_stat("Energy")
    if not energy_stat: return
    energy_stat.apply_changes.rpc(0.0, 0.0, energy_amount)
    picked_up.emit()
