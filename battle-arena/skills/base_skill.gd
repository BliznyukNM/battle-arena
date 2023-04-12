class_name BaseSkill extends Area3D


signal activated(skill: BaseSkill)


@onready var cooldown: Timer = $Cooldown
@onready var execution: Timer = $Execution


func _ready() -> void:
    assert(owner)
    collision_mask = collision_mask & (~owner.collision_layer)


func activate(pressed: bool) -> void:
    if not cooldown.is_stopped(): return
    
    if pressed: _on_pressed()
    else: _on_released()


func _on_pressed() -> void:
    execution.start()
    cooldown.start()
    activated.emit(self)

func _on_released() -> void: pass
