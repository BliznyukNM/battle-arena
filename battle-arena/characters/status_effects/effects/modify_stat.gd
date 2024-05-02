class_name EffectModifyNumberStat extends BaseEffect


@export var stat_name: String
@export_range(-100, 100, 1, "or_greater", "or_less", "suffix:%") var percentage: float
@export var flat: float


func get_bonus(stat: NumberStat) -> float:
    if stat.name != stat_name: return 0.0
    return stat.base_value * percentage * 0.01 + flat
