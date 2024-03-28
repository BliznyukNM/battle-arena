@tool
extends ActionLeaf


@export var animation_name: String


func before_run(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)
    var character = actor.owner
    character.skin.call("stop_%s" % animation_name)
