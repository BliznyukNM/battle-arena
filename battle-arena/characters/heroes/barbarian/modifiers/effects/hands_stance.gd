extends BaseEffect


func trigger(owner: Node) -> void:
    assert(owner is Barbarian)
    owner.current_stance = owner.current_stance & ~Barbarian.Stance.AXE
    owner.skills.secondary_attack.select(1)
    owner.skills.third_attack.select(1)
    
    if owner.current_stance & Barbarian.Stance.DUAL > 0: return
    
    owner.skills.basic_attack.select(1)
    owner.skin.update_stance("hands")


func clear(owner: Node) -> void:
    assert(owner is Barbarian)
    owner.current_stance = owner.current_stance | Barbarian.Stance.AXE
    owner.skills.secondary_attack.select(0)
    owner.skills.third_attack.select(0)
    
    if owner.current_stance & Barbarian.Stance.DUAL > 0: return
    
    owner.skills.basic_attack.select(0)
    owner.skin.update_stance("axe")
