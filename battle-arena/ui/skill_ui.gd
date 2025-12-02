extends TextureRect


@onready var cooldown: Label = $Cooldown


var _skill
var _cooldown_value: float:
	set(value):
		cooldown.visible = not is_zero_approx(value)
		cooldown.text = "%1.1f" % value


func register(skill) -> void:
	if _skill: _skill.blackboard.unbind_var("icon")
	
	_skill = skill
	skill.blackboard.bind_var_to_property("icon", self, "texture")
	skill.blackboard.bind_var_to_property("cooldown", self, "_cooldown_value")
	_cooldown_value = 0.0


func _process(delta: float) -> void:
	if not _skill or not _skill.skill: return
	
	var enabled: bool = _skill.active and is_zero_approx(_cooldown_value)
	modulate = Color.WHITE if enabled else Color.GRAY
