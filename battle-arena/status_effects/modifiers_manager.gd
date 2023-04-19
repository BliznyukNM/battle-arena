extends Node


var _modifiers: Dictionary


func _ready() -> void:
    for child in get_children():
        if not child is BaseModifier: continue
        _modifiers[child.name] = child


func add_modifier(modifier: BaseModifier) -> void:
    _modifiers[modifier.name] = modifier
    add_child(modifier)
    modifier.owner = owner


func remove_modifier(modifier_name: String) -> void:
    var modifier: BaseModifier = _modifiers[modifier_name]
    _modifiers.erase(modifier_name)
    modifier.queue_free()
