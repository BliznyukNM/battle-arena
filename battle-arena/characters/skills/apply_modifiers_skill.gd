extends BaseSkill


@export var modifiers: Array[PackedScene]


func activate(pressed: bool) -> bool:
    if not pressed: return false
    return super.activate(pressed)


func _on_activate(pressed: bool) -> void:
    for modifier_scene in modifiers:
        var modifier: BaseModifier = modifier_scene.instantiate()
        owner.modifiers.add_modifier(modifier)
    super._on_activate(pressed)
