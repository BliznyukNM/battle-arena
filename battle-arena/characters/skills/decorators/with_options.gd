@tool
extends EmptyDecorator


@export var custom_options: Dictionary


func before_run(actor: Node, blackboard: Blackboard) -> void:
    var options: Dictionary = blackboard.get_value("options", {}, owner.name)
    for key in custom_options: options[key] = custom_options[key]
    blackboard.set_value("options", options, owner.name)
