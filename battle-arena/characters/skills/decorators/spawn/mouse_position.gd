@tool
extends EmptyDecorator


@export var max_distance: float


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var position = character.position + (character.input.look_at_point - character.position).limit_length(max_distance)
    var transform = Transform3D.IDENTITY.translated(position)
    
    var options = blackboard.get_value("options", {}, owner.name)
    options.transform = transform
    blackboard.set_value("options", options, owner.name)
    return super(actor, blackboard)
