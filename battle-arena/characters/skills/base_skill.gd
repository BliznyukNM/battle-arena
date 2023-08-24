class_name BaseSkill extends Timer


@export var skill_speed: NumberStat
@export var aiming_time: float
@export var executing_time: float
@export var cooldown_time: float
@export var cancel_cooldown_time: float


enum State {
    READY, AIMING, EXECUTING, COOLDOWN
}


var enabled: bool = true


signal aiming_started(skill: BaseSkill)
signal aiming_finished(skill: BaseSkill)
signal executing_started(skill: BaseSkill)
signal executing_finished(skill: BaseSkill)
signal cancelled(skill: BaseSkill)


var _state: State = State.READY
var _collision_mask: int
var _cancelled: bool

var _speed: float:
    get: return 1.0 if not skill_speed else 1.0 / skill_speed.current_value


func _ready() -> void:
    _collision_mask = owner.collision_mask & (~owner.collision_layer)


## Try to activate skill. Here should be only checks for activating, actual logic
## is going to be executed in _on_activate
func activate(pressed: bool) -> void:
    if not enabled: return
    if not is_multiplayer_authority(): return
    if not _state == State.READY: return
    _aim.rpc(pressed)


func cancel() -> void:
    if not is_multiplayer_authority(): return
    if not _state == State.AIMING: return
    _cancel.rpc()


func reset() -> void:
    if not is_stopped(): stop()
    _state = State.READY


@rpc("reliable", "call_local")
func _aim(pressed: bool) -> void:
    _state = State.AIMING
    
    aiming_started.emit(self)
    var success: = await _on_aim()
    aiming_finished.emit(self)
    
    _cancelled = false
    
    if not success: return
    if not multiplayer.is_server(): return
    
    _execute.rpc(pressed)
    

@rpc("reliable", "call_local")
func _execute(pressed: bool) -> void:
    _state = State.EXECUTING
    
    executing_started.emit(self)
    await _on_execute()
    executing_finished.emit(self)
    
    _on_cooldown(cooldown_time)


@rpc("reliable", "call_local")
func _cancel() -> void:
    _cancelled = true
    
    if not is_stopped():
        stop()
        timeout.emit()
    
    _on_cooldown(cancel_cooldown_time)


func _on_aim() -> bool:
    if is_equal_approx(aiming_time, 0.0): return true
    start(aiming_time * _speed)
    await timeout
    return not _cancelled


func _on_execute() -> void:
    if is_equal_approx(executing_time, 0.0): return
    start(executing_time * _speed)
    await timeout


func _on_cooldown(time: float) -> void:
    _state = State.COOLDOWN
    if time > 0.0:
        start(time * _speed)
        await timeout
    _state = State.READY
