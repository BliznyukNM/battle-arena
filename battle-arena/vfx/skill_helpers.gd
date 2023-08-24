extends Node


func show_line(skill: BaseSkill) -> void:
    if not is_multiplayer_authority(): return


func show_circle(skill: BaseSkill) -> void:
    if not is_multiplayer_authority(): return


func hide() -> void:
    if not is_multiplayer_authority(): return
