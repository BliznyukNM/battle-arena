extends ActionLeaf


@export var duration: float


func before_run(actor: Node, blackboard: Blackboard) -> void:
    var character = actor.owner
    character.skills.emit_signal("show_progress_bar", duration)
