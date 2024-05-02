class_name BaseEffect extends Resource


var name: String:
    get = get_effect_name


func get_effect_name() -> String: return ""
    

func process(owner: Node) -> void: pass
func apply(owner: Node) -> void: pass
func clear(owner: Node) -> void: pass
