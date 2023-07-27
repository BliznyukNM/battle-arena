extends "res://characters/character.gd"


var is_recalling: bool


var _thrown_axe


func on_throw_axe(axe) -> void:
    _thrown_axe = axe
    skills.basic_attack.select(0) # TODO: change to 1
    skills.secondary_attack.select(1)
    skin.update_stance("hands")


func on_recall_axe() -> void:
    assert(_thrown_axe)
    _thrown_axe.recall()
    is_recalling = true


func on_pickup_axe() -> void:
    _thrown_axe = null
    skills.basic_attack.select(0)
    skills.secondary_attack.select(0)
    skin.update_stance("axe")
    is_recalling = false
