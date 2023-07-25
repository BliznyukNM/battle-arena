extends Node


@onready var basic_attack: = get_node_or_null("BasicAttack")
@onready var secondary_attack: = get_node_or_null("SecondaryAttack")
@onready var block: = get_node_or_null("Block")
@onready var dodge: = get_node_or_null("Dodge")
@onready var ultimate: = get_node_or_null("Ultimate")


var _skills: Array


func _ready() -> void:
    for skill in get_children():
        _skills.append(skill)


func _activate_skill(skill, pressed: bool) -> void:
    if _skills.any(func(s): return s != skill and not s.execution.is_stopped()): return
    skill.activate(pressed)


func activate_basic_attack(pressed: bool) -> void:
    _activate_skill(basic_attack, pressed)


func activate_secondary_attack(pressed: bool) -> void:
    _activate_skill(secondary_attack, pressed)


func activate_block(pressed: bool) -> void:
    _activate_skill(block, pressed)
