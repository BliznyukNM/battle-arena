extends "res://skills/base_skill.gd"


@export var damage: int
@export var hit_time: float


@onready var slowdown_effect: BaseStatusEffect = preload("res://status_effects/slowdown.tres").duplicate()
@onready var slow_rotation_effect: BaseStatusEffect = preload("res://status_effects/slow_rotation.tres").duplicate()


func _ready() -> void:
    assert(cooldown.time_left >= execution.time_left, \
        "Execution time have to be bigger or equal than cooldown.")
    super._ready()
    slowdown_effect.time = execution.wait_time
    slow_rotation_effect.time = execution.wait_time


func _on_pressed() -> void:
    super._on_pressed()
    
    %StatusEffects.add_status_effect(slowdown_effect)
    %StatusEffects.add_status_effect(slow_rotation_effect)
    
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
