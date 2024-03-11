@tool
@icon("res://addons/beehave/icons/until_fail.svg")
class_name RunUntil extends ActionLeaf


const Utils = preload("res://characters/skills/utils/utils.gd")


## Expression representing a blackboard key.
@export_placeholder(Utils.EXPRESSION_PLACEHOLDER) var key: String = ""

@onready var _key_expression: Expression = Utils.parse_expression(key, ["actor"])


func tick(actor: Node, blackboard: Blackboard) -> int:
    var key_value: Variant = _key_expression.execute([actor], blackboard)
    
    if _key_expression.has_execute_failed():
        return FAILURE
    
    return SUCCESS if blackboard.has_value(key_value) else RUNNING
