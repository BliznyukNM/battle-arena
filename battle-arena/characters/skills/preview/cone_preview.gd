extends "res://characters/skills/preview/base_preview.gd"


@export var _mesh: Mesh


func _construct_mesh() -> Mesh:
    var options: Dictionary = _get_options.call()
    var radius: float = options.get("distance", 0.0)
    var angle: float = options.get("angle", 60.0)
    _view.scale = Vector3.ONE * radius * 2
    _mesh.surface_get_material(0).set_shader_parameter("angle", float(angle))
    return _mesh
