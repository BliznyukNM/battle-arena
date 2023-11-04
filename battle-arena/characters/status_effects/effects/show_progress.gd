class_name EffectShowProgress extends BaseEffect


@export var modifier_name: String


func trigger(owner: Node) -> void:
    var modifier: TimedModifier = owner.modifiers.get_modifier(modifier_name)
    assert(modifier, "Cannot find %s modifier in %s" % [modifier_name, owner.name])
    owner.hud.on_timed_modifier_started(modifier)
