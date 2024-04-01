@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
    var barbarian = actor.owner
    if not barbarian.is_recalling: barbarian.recall_axe.rpc()
    return SUCCESS
