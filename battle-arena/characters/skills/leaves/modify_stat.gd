@tool
extends ActionLeaf


@export var stat_name: String
@export_range(-100, 100, 1, "or_greater", "or_less", "suffix:%") var percentage: float
@export var flat: float
@export var current: float


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var stat: NumberStat = character.stats.get_stat(stat_name)
    if not stat: return FAILURE
    
    stat.percentual_modifier += percentage * 0.01
    stat.flat_modifier += flat
    stat.current_value += current
    return SUCCESS
