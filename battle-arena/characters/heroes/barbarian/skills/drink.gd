extends BaseSkill


@export var heal: float
@export var energy_cost: float


var _energy_stat: NumberStat:
    get: return owner.stats.get_stat("Energy")


func activate(pressed: bool) -> void:
    if not pressed: return
    if not is_equal_approx(energy_cost, 0.0) and _energy_stat.current_value < energy_cost: return
    super.activate(pressed)


func _on_activate(pressed: bool) -> void:
    super._on_activate(pressed)
    _energy_stat.current_value -= energy_cost


func cancel() -> void:
    pass


func _on_finish() -> void:
    super._on_finish()
    owner.hit_box.on_heal.emit(heal)
