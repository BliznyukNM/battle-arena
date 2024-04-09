extends Node


@export var health_stat: NumberStat


func on_damage(source: Character, damage: float) -> void:
    assert(health_stat)
    if not is_zero_approx(health_stat.current_value): return
    owner.apply_bonuses(source)
    owner.queue_free()
