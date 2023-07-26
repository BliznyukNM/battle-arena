extends Node


@export var health: NumberStat
@export var shield: NumberStat


var invulnerable: BaseStat:
    get: return owner.stats.get_stat("Invulnerable")


func apply(value: float) -> void:
    if invulnerable: return
    
    if shield:
        var shield_old_value = shield.current_value
        shield.current_value -= value
        value -= shield_old_value
    
    if value <= 0: return
    
    if health: health.current_value -= value
