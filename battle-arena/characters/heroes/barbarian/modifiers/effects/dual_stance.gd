extends BaseEffect


func trigger(owner: Node) -> void:
    assert(owner is Barbarian)
    owner.current_stance = owner.current_stance | Barbarian.Stance.DUAL
    
    owner.skills.basic_attack.select(2)
    owner.skin.update_stance("dual")


func clear(owner: Node) -> void:
    assert(owner is Barbarian)
    owner.current_stance = owner.current_stance & ~Barbarian.Stance.DUAL
    
    var is_axe_stance = owner.current_stance & Barbarian.Stance.AXE > 0
    owner.skills.basic_attack.select(0 if is_axe_stance else 1)
    owner.skin.update_stance("axe" if is_axe_stance else "hands")

