extends Node


@export var basic_stats: Array[BaseStat]


var _stats: Dictionary


func _ready() -> void:
    for stat in basic_stats:
        _stats[stat.resource_name] = stat.duplicate()


func get_stat(stat_name: String) -> BaseStat:
    return _stats[stat_name]


func has_stat(stat_name: String) -> bool:
    return _stats.has(stat_name)
