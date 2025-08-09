@tool
extends BTAction


@export_enum("HANDS:0", "AXE:1") var stance: int


func _tick(delta: float) -> int:
	blackboard.top().set_var("stance", stance)
	return SUCCESS
