extends Node


@export var active: bool
@export var interruptable: bool
@export var skill_index: = 0


var skill: BTPlayer:
	get: return null if get_child_count() == 0 else get_child(0)

var execution: float:
	get: return skill.blackboard.get_var(&"execution", 0.0)

var cooldown: float:
	get: return skill.blackboard.get_var(&"cooldown", 0.0)

var title: String:
	get: return tr(self.root_name)

var description: String:
	get: return tr("%s_desc" % self.root_name)

var icon: Texture2D:
	get: return skill.get_meta("icon")

var root_name: String:
	get: return skill.name

var blackboard: Blackboard:
	get: return skill.blackboard

var valid: bool:
	get: return skill != null


func activate(pressed: bool) -> void:
	skill.blackboard.set_var(&"ready", pressed)


func reset() -> void:
	# interrupt()
	
	# FIXME hack to clean all things after
	# interrupt nodes will start and set their values
	await get_tree().process_frame
	skill.blackboard.clear()
