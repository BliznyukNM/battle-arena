extends Label


@onready var cooldown: Label = $Cooldown


var _skill: BaseSkill


func register(skill: BaseSkill) -> void:
    _skill = skill


func _process(delta: float) -> void:
    if not _skill: return
    cooldown.visible = not _skill.cooldown.is_stopped()
    cooldown.text = "%1.2f" % _skill.cooldown.time_left
    
    var enabled: = _skill.enabled and _skill.cooldown.is_stopped()
    add_theme_color_override("font_color", Color.WHITE if enabled else Color.GRAY) 
