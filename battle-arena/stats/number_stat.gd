class_name NumberStat extends BaseStat


@export var has_max_value: bool = true
@export var max_value: float:
    get: return max_value if has_max_value else 1e100

@export var has_min_value: bool = false
@export var min_value: float:
    get: return min_value if has_min_value else -1e100

@export var flat_value: float:
    set(value):
        var old_value: = current_value
        flat_value = value
        if current_value != old_value: changed.emit(old_value, current_value)


var multiplier: float:
    set(value):
        var old_value: = current_value
        multiplier = value
        if current_value != old_value: changed.emit(old_value, current_value)


var current_value: float:
    get:
        return clamp(flat_value, min_value, max_value) * max(1 + multiplier, -1)
