class_name ModifierManager extends Node


var _modifiers: Dictionary


func _ready() -> void:
    for child in get_children():
        if not child is BaseModifier: continue
        _modifiers[child.name] = child


func add_modifier(modifier: BaseModifier) -> void:
    _modifiers[modifier.name] = modifier
    add_child(modifier)
    modifier.owner = owner
    modifier.tree_exiting.connect(func(): _modifiers.erase(modifier.name))


func get_modifier(modifier_name: String) -> BaseModifier:
    if _modifiers.has(modifier_name):
        return _modifiers[modifier_name]
    else: return null


func has_modifier(modifier_name: String) -> bool:
    return _modifiers.has(modifier_name)


func remove_modifier_by_name(modifier_name: String) -> void:
    var modifier = _modifiers.get(modifier_name)
    remove_modifier(modifier)


func remove_modifier(modifier: BaseModifier) -> void:
    if modifier == null or not _modifiers.has(modifier.name): return
    _modifiers.erase(modifier.name)
    remove_child(modifier)
    modifier.queue_free()


func reset() -> void:
    for modifier_name in _modifiers:
        var modifier: BaseModifier = _modifiers[modifier_name]
        modifier.reset()
