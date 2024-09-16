@tool
extends ActionLeaf


@export var animation_name: String


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not animation_name.is_empty():
		var character = actor.owner
		character.skin.call("play_%s" % animation_name)
	return SUCCESS
