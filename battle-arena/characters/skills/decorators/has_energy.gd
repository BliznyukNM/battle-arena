@tool
extends EmptyDecorator


@export_range(0, 100, 1) var energy_amount: int
@export_enum("SUCCESS", "FAILURE") var fail_result: int


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var energy_stat: NumberStat = character.stats.get_stat("Energy")
    
    if energy_stat.current_value < energy_amount: return fail_result
    return super(actor, blackboard)
