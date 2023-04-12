extends Node


@export var input: PlayerInput
@export var speed: float = 10.0


func _process(delta: float) -> void:
    var new_basis: Basis = Basis.looking_at(owner.position - input.look_at_point)
    var weight = delta * speed
    owner.transform.basis = lerp(owner.transform.basis, new_basis, weight)
    
    owner.rotation.x = 0.0
    owner.rotation.z = 0.0


func _on_skill_activate(skill: BaseSkill) -> void:
    set_process(false)
    await skill.execution.timeout
    set_process(true)
