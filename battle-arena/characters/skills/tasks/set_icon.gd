@tool
extends BTAction


@export_file("*.png") var icon_path: String


func _generate_name() -> String:
	return "Set icon: %s" % icon_path


func _tick(delta: float) -> Status:
	blackboard.top().set_var("icon", load(icon_path))
	return SUCCESS
