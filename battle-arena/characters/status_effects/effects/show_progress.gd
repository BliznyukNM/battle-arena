class_name EffectShowProgress extends BaseEffect


func trigger(owner: Node) -> void:
    owner.hud.on_timed_modifier_started(_parent)
