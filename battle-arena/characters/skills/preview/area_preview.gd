extends "res://characters/skills/preview/base_preview.gd"


@export var _mesh: Mesh


func _construct_mesh(distance: float, radius: float) -> Mesh:
    _view.scale = Vector3.ONE * radius * 2
    return _mesh
