class_name BaseSkill extends Node


@export_range(0.0, 100.0, 1.0, "suffix:%") var energy_cost: float
@export var skill_speed: NumberStat


var energy_stat: NumberStat:
    get:
        if not energy_stat: energy_stat = owner.stats.get_stat("Energy")
        return energy_stat


var enabled: bool = true


signal activated(skill: BaseSkill)
signal cancelled(skill: BaseSkill)


var cooldown: SkillTimer: get = _get_cooldown
var execution: SkillTimer: get = _get_execution


var _collision_mask: int


var speed: float:
    get: return 1.0 if not skill_speed else 1.0 / skill_speed.current_value


func _ready() -> void:
    _collision_mask = owner.collision_mask & (~owner.collision_layer)
    execution.timeout.connect(finish)


func _get_cooldown() -> SkillTimer:
    return $Cooldown


func _get_execution() -> SkillTimer:
    return $Execution


## Try to activate skill. Here should be only checks for activating, actual logic
## is going to be executed in _on_activate
func activate(pressed: bool) -> bool:
    if not enabled: return false
    if not is_multiplayer_authority(): return false
    if not cooldown.is_stopped(): return false
    if not is_equal_approx(energy_cost, 0.0) and energy_stat.current_value < energy_cost:
        return false
    _on_activate.rpc(pressed)
    return true


@rpc("reliable", "call_local")
func _on_activate(pressed: bool) -> void:
    if energy_stat: energy_stat.current_value -= energy_cost
    execution.activate(speed)
    activated.emit(self)


func cancel() -> void:
    if not is_multiplayer_authority(): return
    _on_cancel.rpc()


@rpc("reliable", "call_local")
func _on_cancel() -> void:
    _stop_execution()
    cancelled.emit(self)
    cooldown.start(0.5)


func finish() -> void:
    if not is_multiplayer_authority(): return
    _on_finish.rpc()


@rpc("reliable", "call_local")
func _on_finish() -> void:
    _stop_execution()
    cooldown.activate()


func _stop_execution() -> void:
    if execution.is_stopped(): return
    execution.stop()
    execution.timeout.emit()


func reset() -> void:
    if not execution.is_stopped():
        execution.stop()
        execution.timeout.emit()
    
    cooldown.stop()
