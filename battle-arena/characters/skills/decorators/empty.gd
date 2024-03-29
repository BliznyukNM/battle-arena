@tool
class_name EmptyDecorator extends Decorator


func tick(actor: Node, blackboard: Blackboard) -> int:
    var c = get_child(0)

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
            c.after_run(actor, blackboard)
            return response
        RUNNING:
            running_child = c
            if c is ActionLeaf:
                blackboard.set_value("running_action", c, str(actor.get_instance_id()))
            return RUNNING
        _:
            push_error("This should be unreachable")
            return -1


func _get_leaf(node: Node) -> Leaf:
    if node is Leaf: return node
    return _get_leaf(node.get_child(0))
