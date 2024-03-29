@tool
@icon("res://addons/beehave/icons/selector_reactive.svg")
extends Composite


const Utils = preload("res://characters/skills/utils/utils.gd")


@export_placeholder(Utils.EXPRESSION_PLACEHOLDER) var key: String = ""


@onready var _key_expression: Expression = Utils.parse_expression(key, ["actor"])


func tick(actor: Node, blackboard: Blackboard) -> int:
    var key_value: Variant = _key_expression.execute([actor], blackboard)
    
    if _key_expression.has_execute_failed():
        return FAILURE
    
    var child_index: int = blackboard.get_value(key_value, 0)
    
    for i in get_child_count():
        if i != child_index: continue
        
        var c = get_child(i)

        if c != running_child:
            c.before_run(actor, blackboard)

        var response = c.tick(actor, blackboard)
        if can_send_message(blackboard):
            BeehaveDebuggerMessages.process_tick(c.get_instance_id(), response)

        if c is ConditionLeaf:
            blackboard.set_value("last_condition", c, str(actor.get_instance_id()))
            blackboard.set_value("last_condition_status", response, str(actor.get_instance_id()))

        match response:
            SUCCESS, FAILURE:
                _cleanup_running_task(c, actor, blackboard)
                c.after_run(actor, blackboard)
                return response
            RUNNING:
                running_child = c
                if c is ActionLeaf:
                    blackboard.set_value("running_action", c, str(actor.get_instance_id()))
                return RUNNING

    return FAILURE


func after_run(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)


func interrupt(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)


## Changes `running_action` and `running_child` after the node finishes executing.
func _cleanup_running_task(finished_action: Node, actor: Node, blackboard: Blackboard):
    var blackboard_name = str(actor.get_instance_id())
    if finished_action == running_child:
        running_child = null
        if finished_action == blackboard.get_value("running_action", null, blackboard_name):
            blackboard.set_value("running_action", null, blackboard_name)


func get_class_name() -> Array[StringName]:
    var classes := super()
    classes.push_back(&"SelectorIndex")
    return classes
