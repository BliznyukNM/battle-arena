@tool
extends BTDecorator


@export var offset: Vector3


func _tick(delta: float) -> int:
	var character = agent
	
	var spawn_transform: Transform3D = character.transform
	spawn_transform = spawn_transform.translated_local(offset)
	
	var options: Dictionary = blackboard.get_var("options", {})
	options.transform = spawn_transform
	# blackboard.set_value("options", options)
	
	return get_child(0).execute(delta)
