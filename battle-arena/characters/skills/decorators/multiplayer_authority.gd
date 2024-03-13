@tool
extends EmptyDecorator


@export_enum("SUCCESS", "FAILURE") var result: int


func tick(actor: Node, blackboard: Blackboard) -> int:
    if not is_multiplayer_authority(): return result
    return super(actor, blackboard)


func get_class_name() -> Array[StringName]:
    var classes := super()
    classes.push_back(&"MultiplayerAuthority")
    return classes
