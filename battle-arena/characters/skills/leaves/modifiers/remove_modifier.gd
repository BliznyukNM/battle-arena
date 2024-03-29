@tool
extends ActionLeaf


@export var modifier_name: String


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    character.modifiers.remove_modifier_by_name(modifier_name)
    return SUCCESS
