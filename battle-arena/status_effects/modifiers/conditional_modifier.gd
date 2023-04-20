class_name ConditionalModifier extends BaseModifier


@export_multiline var condition: String = "true"


var _condition_expression: Expression


func _ready() -> void:
    super._ready()
    _condition_expression = Expression.new()
    var parsing_result: = _condition_expression.parse(condition)
    assert(parsing_result == OK)


func _process(delta: float) -> void:
    _current_condition = _condition_expression.execute([], self)
    assert(not _condition_expression.has_execute_failed())
