class_name BaseSkill extends Node


signal activated(skill: BaseSkill)


@onready var cooldown: Timer = $Cooldown
@onready var execution: Timer = $Execution


func _ready() -> void:
    assert(cooldown.time_left >= execution.time_left, \
        "Execution time have to be bigger or equal than cooldown.")


func activate(pressed: bool) -> void:
    if not cooldown.is_stopped(): return
    if pressed: _on_activate()


func _on_activate() -> void:
    execution.start()
    cooldown.start()
    activated.emit(self)
