@tool
extends ActionLeaf


@export var duration: float


var scale: float = 1.0


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    character.skills.emit_signal("show_progress_bar", duration * scale)
    return SUCCESS
