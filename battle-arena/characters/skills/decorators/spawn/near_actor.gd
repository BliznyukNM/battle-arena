@tool
extends EmptyDecorator


@export var offset: Vector3


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    
    var spawn_transform: Transform3D = character.transform
    spawn_transform = spawn_transform.translated_local(offset)
    
    var options: Dictionary = blackboard.get_value("options", {}, owner.name)
    options.transform = spawn_transform
    blackboard.set_value("options", options, owner.name)
    
    return super(actor, blackboard)
