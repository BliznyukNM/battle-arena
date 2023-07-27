extends BaseSkill


func activate(pressed: bool) -> void:
    if not pressed or owner.is_recalling: return
    super.activate(pressed)
    owner.on_recall_axe()


func cancel() -> void:
    pass
