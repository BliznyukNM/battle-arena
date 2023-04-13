extends BaseStatusEffect


@export_range(0, 100, 1, "suffix:%") var amount: int


func apply_stats_modifiers(stats) -> void:
    var movement: NumberStat = stats.get_stat("movement_speed")
    movement.multiplier -= amount / 100.0


func clear_stats_modifiers(stats) -> void:
    var movement: NumberStat = stats.get_stat("movement_speed")
    movement.multiplier += amount / 100.0
