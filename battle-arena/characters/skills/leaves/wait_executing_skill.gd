@tool
extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    var skill = character.skills.last_used_skill
    
    if skill and actor != skill and not is_zero_approx(skill.execution):
        if not skill.interruptable: return FAILURE
    
    character.skills.last_used_skill = actor
    return SUCCESS
