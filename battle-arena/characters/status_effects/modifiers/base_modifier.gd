class_name BaseModifier extends Node


@export var effects: Array[BaseEffect]
@export var default_condition: bool = true


var _current_condition: bool


func get_bonus(stat: NumberStat) -> float:
    if not _current_condition: return 0.0
    
    var bonus: = 0.0
    
    for effect in effects:
        if not effect is EffectModifyNumberStat: continue
        bonus += effect.get_bonus(stat)
    
    return bonus


func _ready() -> void: reset()


func reset() -> void:
    self._current_condition = default_condition
