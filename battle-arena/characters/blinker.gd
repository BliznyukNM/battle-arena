extends Node


@export var target_paths: Array[NodePath]
@export var input: PlayerInput
@export var material: Material
@export var colors: Gradient


@onready var targets: = target_paths.map(func(t): return get_node(t))
@onready var blink_material: BaseMaterial3D = material.duplicate()


func _ready() -> void:
    blink_material.albedo_color.a = 0
    for target in targets:
        target.material_overlay = blink_material


func blink(delta: float, is_damage: bool) -> void:
    var is_local: = input and input.is_local
    var color: Color
    
    if not is_damage:
        color = colors.sample(1)
    elif is_local:
        color = colors.sample(0.5)
    else:
        color = colors.sample(0)
    
    var tween = create_tween().set_parallel(true)
    
    for target in targets:
        color.a = 0
        target.material_overlay.albedo_color = color
        color.a = 1
        tween.tween_property(target.material_overlay, "albedo_color", color, 0.1)
        color.a = 0
        tween.chain().tween_property(target.material_overlay, "albedo_color", color, 0.1)
        
