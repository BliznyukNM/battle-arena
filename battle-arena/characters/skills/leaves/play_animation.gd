@tool
extends ActionLeaf


@export var animation_name: String


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character = actor.owner
    character.skin.call("play_%s" % animation_name)
    return SUCCESS
