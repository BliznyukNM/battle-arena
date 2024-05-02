extends Node


@export var health: NumberStat
@export var barrier: NumberStat


var invulnerable: bool:
    get:
        if not "modifiers" in owner: return false
        return owner.modifiers.has_effect("Invulnerability")


func apply(source: Character, value: float) -> void:
    if invulnerable: return
    
    if barrier:
        var barrier_old_value = barrier.current_value
        barrier.current_value -= value
        value -= barrier_old_value
    
    if value <= 0: return
    
    if health: health.current_value -= value
