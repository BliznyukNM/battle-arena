@tool
extends BTAction


@export var stat_name: String
@export_range(-100, 100, 1, "or_greater", "or_less", "suffix:%") var percentage: float
@export var flat: int


func _generate_name() -> String:
	return "ModifyStat: %s +%d, +%d%%" % ["???" if stat_name.is_empty() else stat_name, flat, percentage]


func _tick(delta: float) -> Status:
	var stat: NumberStat = agent.stats.get_number_stat(stat_name)
	if not stat: return FAILURE
	
	stat.set_current_value.rpc(stat.current_value + stat.base_value * (percentage * 0.01) + flat)
	return SUCCESS
	
