extends BaseSkill


@export var heal: float
@export var energy_cost: float


var _energy_stat: NumberStat:
    get: return owner.stats.get_stat("Energy")


func activate(pressed: bool) -> void:
    if not pressed: return
    if _energy_stat.current_value < energy_cost: return
    _energy_stat.current_value -= energy_cost
    super.activate(pressed)


func cancel() -> void:
    pass


func finish() -> void:
    super.finish()
    owner.hit_box.on_heal.emit(heal)
