extends "res://characters/skills/preview/base_preview.gd"


@export var _mesh: Mesh


func _construct_mesh(skill: BaseSkill) -> Mesh:
    _view.scale = Vector3.ONE * skill.radius * 2
    return _mesh
