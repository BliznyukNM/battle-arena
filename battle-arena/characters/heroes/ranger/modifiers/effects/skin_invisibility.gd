extends BaseEffect


func trigger(owner: Node) -> void:
    owner.skin.activate_invisibility()


func clear(owner: Node) -> void:
    owner.skin.deactivate_invisibility()
