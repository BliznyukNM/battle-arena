class_name BaseEffect extends Resource


var _parent: BaseModifier


func set_parent(parent: BaseModifier) -> void:
    _parent = parent
    

func process(owner: Node) -> void: pass
func apply(owner: Node) -> void: pass
func clear(owner: Node) -> void: pass
