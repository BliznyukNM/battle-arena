class_name EffectAttackSpeed extends BaseEffect


@export_range(-100, 100, 1, "suffix:%", "or_greater") var amount: int


func trigger(owner) -> void:
    _apply_stats_modifiers(owner.stats)


func clear(owner) -> void:
    _clear_stats_modifiers(owner.stats)


func _apply_stats_modifiers(stats) -> void:
    var movement: NumberStat = stats.get_stat("AttackSpeed")
    movement.percentual_modifier += amount / 100.0


func _clear_stats_modifiers(stats) -> void:
    var movement: NumberStat = stats.get_stat("AttackSpeed")
    movement.percentual_modifier -= amount / 100.0
