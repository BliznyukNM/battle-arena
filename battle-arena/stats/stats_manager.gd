extends Node


func get_stat(stat_name: String) -> BaseStat:
    return get_node(stat_name) as BaseStat


func has_stat(stat_name: String) -> bool:
    return has_node(stat_name)
