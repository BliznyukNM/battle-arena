extends Node


@export var energy_amount: int


signal picked_up


func apply_bonuses(character: Character) -> void:
    if not character: return
    if not is_multiplayer_authority(): return
    
    var energy_stat: NumberStat = character.stats.get_number_stat("Energy")
    if not energy_stat: return
    energy_stat.set_current_value.rpc(energy_stat.current_value + energy_amount)
    picked_up.emit()
