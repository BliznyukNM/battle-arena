class_name SkillTimer extends Timer


@export var base_time: float


func activate(speed_multiplier: float) -> void:
    start(base_time * speed_multiplier)
