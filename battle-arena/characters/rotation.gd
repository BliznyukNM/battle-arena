extends Node


@export var input: PlayerInput


@onready var speed: NumberStat = %Stats.get_stat("rotation_speed")


func _process(delta: float) -> void:
    var new_basis: Basis = Basis.looking_at(owner.position - input.look_at_point)
    var weight = delta * speed.current_value
    owner.transform.basis = lerp(owner.transform.basis, new_basis, clampf(weight, 0, 1))
    
    owner.rotation.x = 0.0
    owner.rotation.z = 0.0
