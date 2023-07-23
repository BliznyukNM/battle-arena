class_name SkillTimer extends Timer


@export_range(0.1, 60, 0.1, "or_greater") var base_time: float


func _ready() -> void:
    wait_time = base_time


func activate(speed_multiplier: float = 1.0) -> void:
    start(base_time * speed_multiplier)
