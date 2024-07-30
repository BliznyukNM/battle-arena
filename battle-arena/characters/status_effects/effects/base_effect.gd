class_name BaseEffect extends Resource


var name: String:
    get = get_effect_name


func get_effect_name() -> String: return ""

func apply(owner: Node, modifier: BaseModifier) -> void: pass
func process(owner: Node, modifier: BaseModifier) -> void: pass
func clear(owner: Node, modifier: BaseModifier) -> void: pass
