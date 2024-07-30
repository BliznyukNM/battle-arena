class_name EffectDisableHUD extends BaseEffect


func apply(owner: Node, modifier: BaseModifier) -> void:
    owner.hud.visible = false

func clear(owner: Node, modifier: BaseModifier) -> void:
    owner.hud.visible = true
    
