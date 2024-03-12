extends ProgressBar


func _ready() -> void:
    stop()


func execute(duration: float) -> void:
    visible = true
    value = 0
    max_value = duration
    set_process(true)


func stop() -> void:
    visible = false
    set_process(false)


func _process(delta: float) -> void:
    value += delta
    if value >= max_value: stop()
