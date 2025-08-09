extends TextureRect


@onready var cooldown: Label = $Cooldown


var _skill


func register(skill) -> void:
	if _skill: _skill.blackboard.unbind_var("icon")
	
	_skill = skill
	skill.blackboard.bind_var_to_property("icon", self, "texture")


func _process(delta: float) -> void:
	if not _skill or not _skill.skill: return
	
	cooldown.visible = not is_zero_approx(_skill.cooldown)
	cooldown.text = "%1.1f" % _skill.cooldown
	
	var enabled: bool = _skill.active and is_zero_approx(_skill.cooldown)
	modulate = Color.WHITE if enabled else Color.GRAY
