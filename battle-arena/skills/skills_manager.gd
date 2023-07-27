extends Node


@onready var basic_attack: = get_node_or_null("BasicAttack")
@onready var secondary_attack: = get_node_or_null("SecondaryAttack")
@onready var third_attack: = get_node_or_null("ThirdAttack")
@onready var block: = get_node_or_null("Block")
@onready var dodge: = get_node_or_null("Dodge")
@onready var ultimate: = get_node_or_null("Ultimate")


var _skills: Array
var _last_used_skill


func _ready() -> void:
    for skill in get_children():
        _skills.append(skill)


func activate_basic_attack(pressed: bool) -> void:
    _activate_skill(basic_attack, pressed)


func activate_secondary_attack(pressed: bool) -> void:
    _activate_skill(secondary_attack, pressed)


func activate_third_attack(pressed: bool) -> void:
    _activate_skill(third_attack, pressed)


func activate_block(pressed: bool) -> void:
    _activate_skill(block, pressed)


func cancel_skill() -> void:
    if not _last_used_skill or _last_used_skill.execution.is_stopped(): return
    _last_used_skill.cancel()


func _activate_skill(skill, pressed: bool) -> void:
    if _last_used_skill and _last_used_skill != skill and not _last_used_skill.execution.is_stopped(): return
    _last_used_skill = skill
    skill.activate(pressed)
