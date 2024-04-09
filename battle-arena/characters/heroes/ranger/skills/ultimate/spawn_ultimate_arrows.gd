@tool
extends "res://characters/skills/leaves/spawn.gd"


@export_range(1, 11, 2) var arrow_count: int = 1
@export var angle: float


func tick(actor: Node, blackboard: Blackboard) -> int:
    var character: Character = actor.owner
    var options = blackboard.get_value("options", {}, owner.name)
    var original_transform: Transform3D = options.transform
    
    for i in range(arrow_count):
        var angle_sign: int = signi((i % 2) * 2 - 1)
        options.transform = original_transform.rotated_local(Vector3.UP, angle_sign * deg_to_rad(angle) * ((i + 1) / 2))
        _spawn(character, options)
    return SUCCESS
