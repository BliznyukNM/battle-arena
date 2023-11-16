extends CanvasLayer


signal pause(on: bool)
signal exit_game


func _enter_tree() -> void:
    visible = false


func _exit_tree() -> void:
    Input.remove_meta("enabled")


func _ready() -> void:
    $VBoxContainer/Exit.pressed.connect(func(): exit_game.emit())


func _process(delta: float) -> void:
    if Input.is_action_just_pressed("ui.pause"):
        _toggle(!visible)


func _toggle(on: bool) -> void:
    visible = on
    pause.emit(on)
    Input.set_meta("enabled", !on)
