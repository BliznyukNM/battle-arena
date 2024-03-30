@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    character.hud.hide_progress_bar()
    return SUCCESS
