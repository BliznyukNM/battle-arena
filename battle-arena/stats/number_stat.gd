class_name NumberStat extends BaseStat


@export var has_max_value: bool = true
@export var max_value: float

@export var has_min_value: bool = false
@export var min_value: float

@export var current_value: float:
    set(value):
        var old_value: = current_value
        if has_max_value: current_value = min(value, max_value)
        if has_min_value: current_value = max(value, min_value)
        if current_value != old_value: changed.emit(old_value, value)
    get:
        return current_value # * %StatusEffects.get_stat_modifier(resource_name)

