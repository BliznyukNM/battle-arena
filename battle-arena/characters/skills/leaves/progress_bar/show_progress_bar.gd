@tool
extends ActionLeaf


@export var duration: float


func tick(actor: Node, blackboard: Blackboard) -> int:
    var scale: float = blackboard.get_value("scale", 1.0, owner.name)
    var character = actor.owner
    character.hud.show_progress_bar(duration * scale)
    return SUCCESS
