@tool
extends SequenceComposite


@export var reset_on_interrupt: bool = true


func interrupt(actor: Node, blackboard: Blackboard) -> void:
    if reset_on_interrupt: _reset()
    else: successful_index += 1
    
    if running_child != null:
        running_child.interrupt(actor, blackboard)
        running_child = null
