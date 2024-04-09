extends Node


@export var health: NumberStat
@export var shield: NumberStat


var invulnerable: BaseStat:
    get:
        if not "stats" in owner: return null
        return owner.stats.get_stat("Invulnerable")


func apply(source: Character, value: float) -> void:
    if invulnerable: return
    
    if shield:
        var shield_old_value = shield.current_value
        shield.current_value -= value
        value -= shield_old_value
    
    if value <= 0: return
    
    if health: health.current_value -= value
