extends "res://characters/character.gd"


var is_recalling: bool


var _thrown_axe: Node


func _ready() -> void:
    on_pickup_axe()


func on_throw_axe(axe) -> void:
    _thrown_axe = axe
    
    skills.basic_attack.select(1)
    skills.secondary_attack.select(1)
    skills.third_attack.select(1)
    
    skin.update_stance("hands")


@rpc("reliable", "call_local")
func on_recall_axe() -> void:
    assert(_thrown_axe)
    _thrown_axe.recall()
    is_recalling = true


@rpc("reliable", "call_local")
func on_pickup_axe() -> void:
    if _thrown_axe: _thrown_axe.queue_free()
    _thrown_axe = null
    
    skills.basic_attack.select(0)
    skills.secondary_attack.select(0)
    skills.third_attack.select(0)
    
    skin.update_stance("axe")
    is_recalling = false
