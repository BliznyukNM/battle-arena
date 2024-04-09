@tool
extends SequenceComposite


@export var finally_node: BeehaveNode
@export var return_on_finish: bool = true


func tick(actor: Node, blackboard: Blackboard) -> int:
    var result = super(actor, blackboard)
    if result != RUNNING and not return_on_finish:
        return super(actor, blackboard)
    return result


func interrupt(actor: Node, blackboard: Blackboard) -> void:
    super(actor, blackboard)
    successful_index = finally_node.get_index()
