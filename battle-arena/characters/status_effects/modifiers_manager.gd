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


func remove_modifier_by_name(modifier_name: String) -> void:
    remove_modifier(_modifiers.get(modifier_name))


func remove_modifier(modifier: BaseModifier) -> void:
    if modifier == null or not _modifiers.has(modifier.name): return
    _modifiers.erase(modifier.name)
    remove_child(modifier)
    modifier.queue_free()
