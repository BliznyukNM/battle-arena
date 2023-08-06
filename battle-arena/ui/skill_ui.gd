extends Label


@onready var cooldown: Label = $Cooldown


var _skill: Node


func register(skill: Node) -> void:
    _skill = skill


func _process(delta: float) -> void:
    if not _skill: return
    cooldown.visible = not _skill.cooldown.is_stopped()
    cooldown.text = "%1.2f" % _skill.cooldown.time_left
