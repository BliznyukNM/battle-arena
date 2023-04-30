class_name ConditionalModifier extends BaseModifier


@export var default_condition: bool
@export_multiline var condition: String = "true"


var _condition_expression: Expression


func _ready() -> void:
    owner = get_parent().owner
    _condition_expression = Expression.new()
    var parsing_result: = _condition_expression.parse(condition)
    assert(parsing_result == OK)


func _process(delta: float) -> void:
    var new_condition = _condition_expression.execute([], self, false, true)
    _current_condition = default_condition if _condition_expression.has_execute_failed() else new_condition
