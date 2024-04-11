@tool
extends ActionLeaf


@export var preview_scene: PackedScene


func tick(actor: Node, blackboard: Blackboard) -> int:
    var preview = preview_scene.instantiate()
    actor.owner.add_child(preview)
    preview.init(func(): return blackboard.get_value("options", {}, owner.name))
    blackboard.set_value("preview", preview, owner.name)
    return SUCCESS
