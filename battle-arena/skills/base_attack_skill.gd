extends "res://skills/base_skill.gd"


@export var damage: int
@export var hit_time: float


func _ready() -> void:
    assert(cooldown.time_left >= execution.time_left, \
        "Execution time have to be bigger or equal than cooldown.")


func _on_pressed() -> void:
    execution.start()
    cooldown.start()
    
    activated.emit(self)
    
    var tween: = create_tween()
    tween.tween_callback(self._try_hit).set_delay(hit_time)


func _try_hit() -> void:
    var areas: = get_overlapping_areas()
    if areas.size() == 0: return
    
    var hitbox: = _get_closest_hitbox(areas)
    if hitbox: hitbox.on_hit.emit(damage)
    

func _get_closest_hitbox(areas: Array[Area3D]) -> HitBox:
    var hitbox: HitBox
    var distance: = 1e20
    
    for area in areas:
        if not area is HitBox: continue
        var new_distance: float = area.position.distance_to(owner.position)
        if new_distance < distance:
            distance = new_distance
            hitbox = area
    
    return hitbox
