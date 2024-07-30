class_name EffectShowProgress extends BaseEffect


func apply(owner: Node, modifier: BaseModifier) -> void:
    owner.hud.on_timed_modifier_started(modifier)
