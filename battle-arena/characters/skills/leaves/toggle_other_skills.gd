@tool
extends ActionLeaf


@export var enable: bool


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    var skills: Array = character.skills._skills
    for skill in skills:
        if actor == skill: continue
        skill.enabled = enable
    return SUCCESS
