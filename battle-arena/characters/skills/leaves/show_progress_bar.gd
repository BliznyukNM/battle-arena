extends ActionLeaf


@export var duration: float


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    character.skills.emit_signal("show_progress_bar", duration)
    return SUCCESS
