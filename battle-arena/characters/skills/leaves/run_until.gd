@tool
extends BTAction

@export var consume_key: bool = true

## Expression representing a blackboard key.
@export_placeholder(Utils.EXPRESSION_PLACEHOLDER) var key: String = ""
@export var blackboard_name: String # = Blackboard.DEFAULT

const Utils = preload("res://characters/skills/utils/utils.gd")

# @onready var _key_expression: Expression = Utils.parse_expression(key, ["actor"])


# func tick(actor: Node, blackboard: Blackboard) -> int:
	# var key_value: Variant = _key_expression.execute([actor], blackboard)
	
	# if _key_expression.has_execute_failed():
	#	return FAILURE
	
	# var result: bool = blackboard.get_value(key_value, false)
	# if result and consume_key: blackboard.erase_value(key_value)
	
	# return SUCCESS if result else RUNNING
