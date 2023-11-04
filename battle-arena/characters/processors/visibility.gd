extends Node


func _process(delta: float) -> void:
    if multiplayer.get_unique_id() == owner.player_id: return
    var has_invisibility = owner.modifiers.has_modifier("Invisibility")
    owner.visible = not has_invisibility
