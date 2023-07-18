class_name BaseSkill extends Node


signal activated(skill: BaseSkill)


@onready var cooldown: Timer = $Cooldown
@onready var execution: Timer = $Execution


var _collision_mask: int


func _ready() -> void:
    if owner: _collision_mask = owner.collision_mask & (~owner.collision_layer)


func activate(pressed: bool) -> void:
    if not cooldown.is_stopped(): return
    if pressed: _on_activate()


func _on_activate() -> void:
    execution.start()
    cooldown.start()
    activated.emit(self)
