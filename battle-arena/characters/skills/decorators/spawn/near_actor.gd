@tool
extends EmptyDecorator


@export var offset: Vector3


func tick(actor: Node, blackboard: Blackboard) -> int:
    var child = get_child(0)
    var character = actor.owner
    
    var spawn_transform: Transform3D = character.transform
    spawn_transform = spawn_transform.translated_local(offset)
    child.spawn_transform = spawn_transform
    return super(actor, blackboard)
