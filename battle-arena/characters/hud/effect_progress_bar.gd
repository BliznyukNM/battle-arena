extends ProgressBar


@export var name_label: Control
@export var effect_name_label: Label


var _modifier: TimedModifier


func _ready() -> void:
    _clear()


func register_modifier(modifier: TimedModifier) -> void:
    _modifier = modifier
    _modifier.tree_exiting.connect(_clear, CONNECT_ONE_SHOT)
    effect_name_label.text = _modifier.name
    value = modifier.time
    set_visibility(true)


func set_visibility(visibility_value: bool) -> void:
    visible = visibility_value
    name_label.visible = !visibility_value
    effect_name_label.visible = visibility_value


func _clear() -> void:
    _modifier = null
    set_visibility(false)


func _process(delta: float) -> void:
    if not _modifier: return
    value = _modifier._current_time / _modifier.time
