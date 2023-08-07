class_name TimedModifier extends ConditionalModifier


@export var time: float = -1


var _current_time: float:
    set(value):
        _current_time = value
        if _current_time <= 0.0:
            _current_condition = false
            queue_free()


func _ready() -> void:
    super._ready()
    _current_time = time


func _process(delta: float) -> void:
    super._process(delta)
    if time >= 0: _current_time -= delta
