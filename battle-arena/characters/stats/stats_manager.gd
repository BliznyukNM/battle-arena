class_name StatManager extends Node


@onready var modifiers = get_node_or_null("../Modifiers")


func _ready() -> void:
    for stat in get_children(): stat.modifiers = modifiers


func get_number_stat(stat_name: String) -> NumberStat:
    return get_node_or_null(stat_name)


func reset() -> void: for stat in get_children(): stat.reset()
