class_name ConditionalModifier extends BaseModifier


@export_multiline var condition: String = "true"


var _condition_expression: Expression

var _current_condition: bool:
    set(value):
        var old_value: = _current_condition
        _current_condition = value
        if old_value != value: trigger_effects(_current_condition)


func _ready() -> void:
    _condition_expression = Expression.new()
    var parsing_result: = _condition_expression.parse(condition)
    assert(parsing_result == OK)


func _exit_tree() -> void:
    if _current_condition: trigger_effects(false)


func _process(delta: float) -> void:
    _current_condition = _condition_expression.execute([], self)
    assert(not _condition_expression.has_execute_failed())
