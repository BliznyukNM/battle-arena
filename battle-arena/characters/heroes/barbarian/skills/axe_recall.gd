extends BaseSkill


func activate(pressed: bool) -> void:
    if not pressed or owner.is_recalling: return
    super.activate(pressed)


func _on_activate(pressed: bool) -> void:
    super._on_activate(pressed)
    owner.on_recall_axe()


func cancel() -> void:
    pass
