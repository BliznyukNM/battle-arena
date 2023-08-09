extends BaseEffect


func trigger(owner: Node) -> void:
    assert(owner is Barbarian)
    owner.current_stance = owner.current_stance | Barbarian.Stance.DUAL
    
    owner.skills.basic_attack.select(2)
    
    owner.skills.secondary_attack.enabled = false
    owner.skills.third_attack.enabled = false
    owner.skills.block.enabled = false
    owner.skills.dodge.enabled = false
    owner.skills.ultimate.enabled = false
    
    owner.skin.update_stance("dual")


func clear(owner: Node) -> void:
    assert(owner is Barbarian)
    owner.current_stance = owner.current_stance & ~Barbarian.Stance.DUAL
    
    var is_axe_stance = owner.current_stance & Barbarian.Stance.AXE > 0
    owner.skills.basic_attack.select(0 if is_axe_stance else 1)
    
    owner.skills.secondary_attack.enabled = true
    owner.skills.third_attack.enabled = true
    owner.skills.block.enabled = true
    owner.skills.dodge.enabled = true
    owner.skills.ultimate.enabled = true
    
    owner.skin.update_stance("axe" if is_axe_stance else "hands")

