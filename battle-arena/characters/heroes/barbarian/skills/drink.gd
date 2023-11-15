extends BaseSkill


@export var heal: float


func activate(pressed: bool) -> bool:
    if not pressed: return false
    return super.activate(pressed)


func cancel() -> void:
    pass


func _on_finish() -> void:
    super._on_finish()
    owner.hit_box.on_heal.emit(heal)
