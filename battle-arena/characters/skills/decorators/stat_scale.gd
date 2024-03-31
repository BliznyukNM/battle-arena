@tool
extends EmptyDecorator


@export var stat_name: String
@export var inverted: bool


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var stat: NumberStat = character.stats.get_stat(stat_name)
    
    if stat:
        var scale: = stat.current_value if not inverted else 1 / stat.current_value
        blackboard.set_value("scale", scale, owner.name)

    return super(actor, blackboard)
