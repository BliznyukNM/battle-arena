@tool
extends BeehaveTree


@export var interruptable: bool


var pressed: bool

var execution: float:
    get: return blackboard.get_value("execution", 0.0, self.root_name)

var cooldown: float:
    get: return blackboard.get_value("cooldown", 0.0, self.root_name)

var title: String:
    get: return tr(self.root_name)

var description: String:
    get: return tr("%s_desc" % self.root_name)

var root_name: String:
    get:
        var running_action: BeehaveNode = blackboard.get_value("running_action", null, str(actor.get_instance_id()))
        if not running_action: return ""
        return running_action.owner.name


func reset() -> void:
    interrupt()
    
    # FIXME hack to clean all things after
    # interrupt nodes will start and set their values
    await get_tree().process_frame 
    blackboard.blackboard.clear()
    blackboard._data.clear()
