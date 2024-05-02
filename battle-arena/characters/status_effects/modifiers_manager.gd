class_name ModifierManager extends Node


@onready var spawner: MultiplayerSpawner = $Spawner


func get_bonus(stat: NumberStat) -> float:
    var bonus: = 0.0
    for modifier in spawner.get_children(): bonus += modifier.get_bonus(stat)
    return bonus


func add_modifier(data: Dictionary) -> BaseModifier:
    var modifier = spawner.spawn(data)
    # modifier.name = data.name
    return modifier


func get_modifier(modifier_name: String) -> BaseModifier:
    return spawner.find_child(modifier_name);


func has_modifier(modifier_name: String) -> bool:
    return spawner.has_node(modifier_name)


func remove_modifier_by_name(modifier_name: String) -> void:
    var modifier: = get_modifier(modifier_name)
    if not modifier: return
    remove_modifier(modifier)


func remove_modifier(modifier: BaseModifier) -> void:
    spawner.remove_child(modifier)
    modifier.queue_free()


func reset() -> void:
    if not is_multiplayer_authority(): return
    for modifier in spawner.get_children(): remove_modifier(modifier)
    spawner.reset()
