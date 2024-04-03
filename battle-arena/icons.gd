extends Node

@export var mapping: Dictionary

func get_icon(icon_name) -> Texture2D:
    return mapping.get(icon_name, null)
