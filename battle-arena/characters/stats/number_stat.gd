class_name NumberStat extends BaseStat


const MAX_VALUE: = 1e100
const MIN_VALUE: = -MAX_VALUE


@export var has_max_value: bool = false
@export var max_value: float:
    get: return max_value if has_max_value else MAX_VALUE

@export var has_min_value: bool = false
@export var min_value: float:
    get: return min_value if has_min_value else MIN_VALUE


@export var base_value: float


var flat_modifier: float:
    set(value):
        var old_value: = current_value
        flat_modifier = value
        if current_value != old_value: changed.emit(old_value, current_value)


var percentual_modifier: float:
    set(value):
        var old_value: = current_value
        percentual_modifier = value
        if current_value != old_value: changed.emit(old_value, current_value)


var current_value: float:
    get:
        return clamp(base_value * max(1 + percentual_modifier, 0) + flat_modifier, min_value, max_value)
    set(value):
        var old_value: = current_value
        flat_modifier += value - old_value
        if current_value != old_value: changed.emit(old_value, current_value)
        
