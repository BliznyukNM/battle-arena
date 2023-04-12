extends Node3D


@export var skill_to_animation: Dictionary


@onready var animator: AnimationPlayer = $Animations


func _ready() -> void:
    animator.play("idle")


func on_skill_activated(skill: BaseSkill) -> void:
    #if animator.current_animation != "":
    #    var current_animation: = animator.get_animation(animator.current_animation)
    #    animator.advance(current_animation.length)
    #    animator.clear_queue()
        
    var animation_name: String = skill_to_animation[skill.name]
    animator.current_animation = ""
    animator.clear_queue()
    animator.play(animation_name)
    animator.queue("back_to_idle")
    animator.queue("idle")
