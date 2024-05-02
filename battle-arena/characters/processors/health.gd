extends Node


@export var health: NumberStat
@export var barrier: NumberStat


var invulnerable: bool:
    get: # FIXME
        # if not "stats" in owner: return null
        # return owner.stats.get_stat("Invulnerable")
        return false


func apply(source: Character, value: float) -> void:
    if invulnerable: return
    
    if barrier:
        var barrier_old_value = barrier.current_value
        barrier.current_value -= value
        value -= barrier_old_value
    
    if value <= 0: return
    
    if health: health.current_value -= value
