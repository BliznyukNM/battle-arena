@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
    var preview: Node = blackboard.get_value("preview", null, owner.name)
    if not preview: return FAILURE
    preview.queue_free()
    blackboard.erase_value("preview", owner.name)
    return SUCCESS
