extends Node


@onready var health_bar: = $SubViewport/HUD/Container/Health
@onready var name_label: = $SubViewport/HUD/Container/Name
@onready var view: = $View
@onready var viewport: = $SubViewport


func _ready() -> void:
    if owner:
        health_bar.max_value = owner.health
        health_bar.value = owner.current_health
        name_label.text = owner.name
    set_process(owner != null)


func _process(_delta: float) -> void:
    health_bar.value = owner.current_health
