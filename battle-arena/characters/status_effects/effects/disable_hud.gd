class_name EffectDisableHUD extends BaseEffect


func trigger(owner: Node) -> void:
    owner.hud.visible = false

func clear(owner: Node) -> void:
    owner.hud.visible = true
    
