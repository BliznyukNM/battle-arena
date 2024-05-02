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


@onready var current_value: float = base_value:
    set = set_current_value,
    get = get_current_value


@rpc("call_local")
func set_current_value(new_value: float) -> void:
    var old_value = current_value
    current_value = clamp(new_value, min_value, max_value)
    if not is_equal_approx(old_value, current_value): changed.emit(old_value, current_value)


func get_current_value() -> float:
    var bonus = 0.0 if not modifiers else modifiers.get_bonus(self)
    return current_value + bonus
