class_name EffectSlowdown extends BaseEffect


@export_range(0, 100, 1, "suffix:%") var amount: int


func trigger(owner) -> void:
    _apply_stats_modifiers(owner.stats)


func clear(owner) -> void:
    _clear_stats_modifiers(owner.stats)


func _apply_stats_modifiers(stats) -> void:
    var movement: NumberStat = stats.get_stat("Movement")
    movement.percentual_modifier -= amount / 100.0


func _clear_stats_modifiers(stats) -> void:
    var movement: NumberStat = stats.get_stat("Movement")
    movement.percentual_modifier += amount / 100.0
