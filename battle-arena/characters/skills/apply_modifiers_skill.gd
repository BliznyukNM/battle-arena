extends BaseSkill


@export_range(0.0, 100.0, 1.0, "suffix:%") var energy_cost: float
@export var energy_stat: NumberStat
@export var modifiers: Array[PackedScene]


func activate(pressed: bool) -> void:
    if not pressed: return
        
    if energy_stat and not is_equal_approx(energy_cost, 0.0) and energy_stat.current_value < energy_cost:
        return
    
    super.activate(pressed)


func _on_activate(pressed: bool) -> void:
    for modifier_scene in modifiers:
        var modifier: BaseModifier = modifier_scene.instantiate()
        owner.modifiers.add_modifier(modifier)
    super._on_activate(pressed)
