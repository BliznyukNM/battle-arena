@tool
extends BTDecorator


@export_enum("SUCCESS", "FAILURE") var result: int

var _is_damaged: bool


func _enter() -> void:
	_is_damaged = false
	agent.hit_box.on_damage.connect(_on_damage)


func _tick(delta: float) -> int:
	if not _is_damaged: return get_child(0).execute(delta)
	# interrupt(actor, blackboard)
	return result


func _exit() -> void:
	agent.hit_box.on_damage.disconnect(_on_damage)


func _on_damage(source: Character, _value: float) -> void:
	_is_damaged = true
