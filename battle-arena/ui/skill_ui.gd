extends TextureRect


@onready var cooldown: Label = $Cooldown


var _skill


func register(skill) -> void:
    _skill = skill


func _process(delta: float) -> void:
    if not _skill: return
    
    var icon = _skill.icon
    if icon: texture = icon
    cooldown.visible = not is_zero_approx(_skill.cooldown)
    cooldown.text = "%1.1f" % _skill.cooldown
    
    var enabled: bool = _skill.enabled and is_zero_approx(_skill.cooldown)
    modulate = Color.WHITE if enabled else Color.GRAY
