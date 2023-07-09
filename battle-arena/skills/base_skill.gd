class_name BaseSkill extends Node


signal activated(skill: BaseSkill)


@onready var cooldown: Timer = $Cooldown
@onready var execution: Timer = $Execution


var _character
var _collision_mask: int


func setup(character) -> void:
    _character = character
    _collision_mask = character.collision_mask & (~character.collision_layer)


func activate(pressed: bool) -> void:
    if not cooldown.is_stopped(): return
    if pressed: _on_activate()


func _on_activate() -> void:
    execution.start()
    cooldown.start()
    activated.emit(self)
