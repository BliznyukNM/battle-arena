extends Node


@export var skills: Array[BaseSkill]
@export var modifiers: Array[String]


func _ready() -> void:
    for skill in skills: skill.execution.timeout.connect(clear)


func clear() -> void:
    for modifier in modifiers: owner.modifiers.remove_modifier_by_name(modifier)
