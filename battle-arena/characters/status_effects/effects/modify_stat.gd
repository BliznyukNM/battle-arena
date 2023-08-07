class_name EffectModifyNumberStat extends BaseEffect


@export var stat_name: String
@export_range(-100, 100, 1, "or_greater", "or_less", "suffix:%") var percentage: float
@export var flat: float


func trigger(owner) -> void:
    _apply_stats_modifiers(owner.stats)


func clear(owner) -> void:
    _clear_stats_modifiers(owner.stats)


func _apply_stats_modifiers(stats) -> void:
    var stat: NumberStat = stats.get_stat(stat_name)
    stat.percentual_modifier += percentage / 100.0
    stat.flat_modifier += flat


func _clear_stats_modifiers(stats) -> void:
    var stat: NumberStat = stats.get_stat(stat_name)
    stat.percentual_modifier -= percentage / 100.0
    stat.flat_modifier -= flat
