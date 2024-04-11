extends "res://characters/skills/preview/base_preview.gd"


@export var _mesh: Mesh


func _construct_mesh() -> Mesh:
    var options: Dictionary = _get_options.call()
    var radius: float = options.get("radius", 1.0)
    _view.scale = Vector3.ONE * radius * 2
    return _mesh
