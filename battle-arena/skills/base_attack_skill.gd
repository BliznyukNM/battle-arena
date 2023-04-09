extends "res://skills/base_skill.gd"


@export var hit_time: float
@export var hit_register_time: float = 0.1


func _ready() -> void:
    assert(cooldown.time_left >= execution.time_left, \
        "Execution time have to be bigger or equal than cooldown.")


func _on_pressed() -> void:
    execution.start()
    cooldown.start()
    
    activated.emit(self)
    
    var tween: = create_tween()
    tween.tween_callback(func(): monitorable = true).set_delay(hit_time)
    tween.tween_callback(func(): monitorable = false).set_delay(hit_register_time)
