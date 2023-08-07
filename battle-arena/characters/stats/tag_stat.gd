class_name TagStat extends BaseStat


@export var current_value: String:
    set(value):
        var old_value: = current_value
        current_value = value
        if old_value != current_value: changed.emit(old_value, current_value)
