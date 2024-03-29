@tool
extends EmptyDecorator


@export var stat_name: String
@export var inverted: bool


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var stat: NumberStat = character.stats.get_stat(stat_name)
    
    if stat:
        var leaf: = _get_leaf(get_child(0))
        assert("scale" in leaf) # TODO: move to warnings in Godot Editor
        leaf.scale = stat.current_value if not inverted else 1 / stat.current_value

    return super(actor, blackboard)
