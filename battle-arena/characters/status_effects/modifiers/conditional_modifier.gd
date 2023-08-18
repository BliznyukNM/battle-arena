class_name ConditionalModifier extends BaseModifier


@export_multiline var condition: String = "true"


var _condition_expression: Expression
var _parsing_result: int


func _ready() -> void:
    owner = get_parent().owner
    _condition_expression = Expression.new()
    _parsing_result = _condition_expression.parse(condition)
    assert(_parsing_result == OK)


func _process(delta: float) -> void:
    if _parsing_result != OK:
        _current_condition = default_condition
    else:
        var new_condition = _condition_expression.execute([], self, true, true)
        _current_condition = default_condition if _condition_expression.has_execute_failed() else new_condition


func reset() -> void:
    pass
