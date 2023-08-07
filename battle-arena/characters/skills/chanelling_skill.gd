extends BaseSkill


func _on_activate(pressed: bool) -> void:
    if not pressed: return
    
    if execution.is_stopped():
        super._on_activate(pressed)
    else:
        finish()
