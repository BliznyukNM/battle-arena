class_name Barbarian extends "res://characters/character.gd"


enum Stance { HANDS = 0, AXE = 1, DUAL = 2 }


var current_stance: Stance = Stance.AXE
var is_recalling: bool
var thrown_axe: Node


func on_throw_axe(axe) -> void:
    thrown_axe = axe


@rpc("reliable", "call_local")
func on_recall_axe() -> void:
    assert(thrown_axe)
    thrown_axe.recall()
    is_recalling = true


@rpc("reliable", "call_local")
func on_pickup_axe() -> void:
    if thrown_axe: thrown_axe.queue_free()
    thrown_axe = null
    is_recalling = false
