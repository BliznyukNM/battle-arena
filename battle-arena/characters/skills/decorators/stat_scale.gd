@tool
extends EmptyDecorator


@export var stat_name: String
@export var inverted: bool


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var stat: NumberStat = character.stats.get_number_stat(stat_name)
    
    assert(not (is_zero_approx(stat.current_value) and inverted))
    
    var scale: float = stat.current_value if not inverted else 1 / stat.current_value
    blackboard.set_value("scale", scale, owner.name)

    return super(actor, blackboard)
