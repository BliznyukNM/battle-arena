class_name Barbarian extends "res://characters/character.gd"


enum Stance { HANDS = 0, AXE = 1, DUAL = 2 }


var is_recalling: bool
var thrown_axe: Node


func on_throw_axe(axe) -> void:
    thrown_axe = axe


@rpc("reliable", "call_local")
func recall_axe() -> void:
    assert(thrown_axe)
    thrown_axe.recall()
    is_recalling = true


@rpc("reliable", "call_local")
func on_pickup_axe() -> void:
    if thrown_axe and is_multiplayer_authority(): thrown_axe.queue_free()
    thrown_axe = null
    is_recalling = false
    skills.blackboard.set_value("axe_recalled", true)
    skills.blackboard.set_value("skill_name", "axe")
    skin.update_stance("axe")
