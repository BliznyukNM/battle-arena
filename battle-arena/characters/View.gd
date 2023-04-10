extends MeshInstance3D


@onready var blink_material: = preload("res://characters/hit_overlay.tres")


func blink(_damage: float) -> void:
    var color = Color.RED # TODO: if owner.is_local else Color.WHITE
    var tween = create_tween()
    
    if material_overlay == null: material_overlay = blink_material.duplicate()
    color.a = 0
    material_overlay.albedo_color = color
    color.a = 1
    tween.tween_property(material_overlay, "albedo_color", color, 0.1)
    color.a = 0
    tween.tween_property(material_overlay, "albedo_color", color, 0.1)
