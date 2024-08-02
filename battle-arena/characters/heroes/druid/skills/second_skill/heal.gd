@tool
extends "res://characters/skills/leaves/melee_attack.gd"


func process_hit(collider: HitBox, character) -> void:
    collider.process_heal(character, damage)
