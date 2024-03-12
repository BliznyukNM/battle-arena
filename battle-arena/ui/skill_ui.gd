extends Label


@onready var cooldown: Label = $Cooldown


var _skill


func register(skill) -> void:
    _skill = skill


func _process(delta: float) -> void:
    if not _skill: return
    
    cooldown.visible = _skill.cooldown > 0.0
    cooldown.text = "%1.2f" % _skill.cooldown
    
    var enabled: bool = _skill.enabled and _skill.cooldown <= 0.0
    add_theme_color_override("font_color", Color.WHITE if enabled else Color.GRAY) 
