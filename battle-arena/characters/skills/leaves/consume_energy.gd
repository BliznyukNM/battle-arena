@tool
extends ActionLeaf


@export_range(0, 100, 1) var energy_amount: int


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var energy_stat: NumberStat = character.stats.get_stat("Energy")
    
    if energy_stat.current_value < energy_amount: return FAILURE
    
    if is_multiplayer_authority():
        energy_stat.apply_changes.rpc(0.0, 0.0, -energy_amount)
    
    return SUCCESS
