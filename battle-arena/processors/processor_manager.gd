extends Node


@onready var health: = get_node_or_null("Health")


func process_damage(value: float) -> float:
    # apply all necessary modifiers
    health.damage(value)
    return value


func process_heal(value: float) -> float:
    # apply all necessary modifiers
    health.heal(value)
    return value
