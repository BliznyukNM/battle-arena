@tool
extends EmptyDecorator


@export_enum("SUCCESS", "FAILURE") var result: int


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    if multiplayer.get_unique_id() != character.player_id: return result
    return super(actor, blackboard)
