extends Node


@export var health: NumberStat


@onready var health_bar: = $SubViewport/HUD/Container/Health
@onready var name_label: = $SubViewport/HUD/Container/Name
@onready var view: = $View
@onready var viewport: = $SubViewport


func _ready() -> void:
    if health and owner:
        health_bar.max_value = health.max_value
        health_bar.value = health.current_value
        name_label.text = owner.name # TODO


func _process(_delta: float) -> void:
    health_bar.value = health.current_value
