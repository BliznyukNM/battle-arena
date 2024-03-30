@tool
extends EmptyDecorator


@export_enum("SUCCESS", "FAILURE") var result: int
@export_placeholder(Utils.EXPRESSION_PLACEHOLDER) var key: String = ""
@export var expected_value: String
@export var blackboard_name: String = Blackboard.DEFAULT


const Utils = preload("res://characters/skills/utils/utils.gd")


@onready var _key_expression: Expression = Utils.parse_expression(key, ["actor"])



func tick(actor: Node, blackboard: Blackboard) -> int:
    var key_value: Variant = _key_expression.execute([actor], blackboard)
    
    if _key_expression.has_execute_failed():
        return FAILURE
    
    var value = blackboard.get_value(key_value)
    if str(value) != expected_value: return super(actor, blackboard)
    
    interrupt(actor, blackboard)
    return result
