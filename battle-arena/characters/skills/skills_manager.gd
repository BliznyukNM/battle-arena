class_name SkillManager extends Node


@onready var basic_attack: BaseSkill = get_node_or_null("BasicAttack")
@onready var secondary_attack: BaseSkill = get_node_or_null("SecondaryAttack")
@onready var third_attack: BaseSkill = get_node_or_null("ThirdAttack")
@onready var block: BaseSkill = get_node_or_null("Block")
@onready var dodge: BaseSkill = get_node_or_null("Dodge")
@onready var ultimate: BaseSkill = get_node_or_null("Ultimate")


var _skills: Array
var _last_used_skill


func _ready() -> void:
    _skills = [basic_attack, secondary_attack, third_attack, block, dodge, ultimate]


func activate_basic_attack(pressed: bool) -> void:
    _activate_skill.rpc(0, pressed)


func activate_secondary_attack(pressed: bool) -> void:
    _activate_skill.rpc(1, pressed)


func activate_third_attack(pressed: bool) -> void:
    _activate_skill.rpc(2, pressed)


func activate_block(pressed: bool) -> void:
    _activate_skill.rpc(3, pressed)


func activate_dodge(pressed: bool) -> void:
    _activate_skill.rpc(4, pressed)


func activate_ultimate(pressed: bool) -> void:
    _activate_skill.rpc(5, pressed)


func cancel_skill() -> void:
    if not _last_used_skill or _last_used_skill.execution.is_stopped(): return
    _last_used_skill.cancel()


@rpc("reliable", "call_local")
func _activate_skill(index: int, pressed: bool) -> void:
    var skill = _skills[index]
    if _last_used_skill and _last_used_skill != skill and not _last_used_skill.execution.is_stopped(): return
    _last_used_skill = skill
    skill.activate(pressed)
