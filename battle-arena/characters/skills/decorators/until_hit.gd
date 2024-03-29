@tool
extends EmptyDecorator


@export_enum("SUCCESS", "FAILURE") var result: int


var _is_damaged: bool


func before_run(actor: Node, blackboard: Blackboard) -> void:
    _is_damaged = false
    var character: Character = actor.owner
    character.hit_box.on_damage.connect(_on_damage)


func tick(actor: Node, blackboard: Blackboard) -> int:
    if not _is_damaged: return super(actor, blackboard)
    return result


func after_run(actor: Node, blackboard: Blackboard) -> void:
    var character: Character = actor.owner
    character.hit_box.on_damage.disconnect(_on_damage)


func _on_damage(_value: float) -> void:
    _is_damaged = true
