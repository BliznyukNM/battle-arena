class_name StatManager extends Node


var _stats: Dictionary


func _ready() -> void:
    for child in get_children():
        if not child is BaseStat: continue
        _stats[child.name] = child


func add_stat(stat: BaseStat) -> void:
    assert(!has_stat(stat.name))
    _stats[stat.name] = stat
    add_child(stat)


func remove_stat(stat_name: String) -> void:
    assert(has_stat(stat_name))
    var stat: = get_stat(stat_name)
    _stats.erase(stat_name)
    stat.queue_free()


func get_stat(stat_name: String) -> BaseStat:
    return _stats.get(stat_name)


func has_stat(stat_name: String) -> bool:
    return _stats.has(stat_name)
