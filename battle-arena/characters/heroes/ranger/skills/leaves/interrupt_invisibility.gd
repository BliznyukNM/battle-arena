@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    if not is_zero_approx(character.skills.block.execution):
        character.skills.block.interrupt()
    return SUCCESS
