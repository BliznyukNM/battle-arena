extends BaseSkill


func activate(pressed: bool) -> bool:
    if not pressed or owner.is_recalling: return false
    return super.activate(pressed)


func _on_activate(pressed: bool) -> void:
    super._on_activate(pressed)
    owner.on_recall_axe()


func cancel() -> void:
    pass
