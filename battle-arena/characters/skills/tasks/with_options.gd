@tool
extends BTDecorator


@export var options: Dictionary


func _generate_name() -> String:
	return "WithOptions: %s" % ("{}" if options.is_empty() else options)


func _enter() -> void: blackboard.set_var("options", options)
func _exit() -> void: blackboard.erase_var("options")
