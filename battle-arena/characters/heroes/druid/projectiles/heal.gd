extends "res://characters/skills/projectiles/grenade.gd"


func _process_hit(hitbox: HitBox) -> bool:
    var health: NumberStat = owner.stats.get_stat("Health")
    if health.current_value >= health.max_value: return false
    hitbox.apply_heal.rpc(skill.heal)
    return true
