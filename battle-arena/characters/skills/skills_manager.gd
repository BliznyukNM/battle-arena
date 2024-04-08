class_name SkillManager extends Node


@onready var basic_attack: BeehaveTree = get_node_or_null("BasicAttack")
@onready var second_attack: BeehaveTree = get_node_or_null("SecondAttack")
@onready var third_attack: BeehaveTree = get_node_or_null("ThirdAttack")
@onready var block: BeehaveTree = get_node_or_null("Block")
@onready var dodge: BeehaveTree = get_node_or_null("Dodge")
@onready var ultimate: BeehaveTree = get_node_or_null("Ultimate")


var enabled: bool = true


var _skills: Array
var _last_used_skill


func _ready() -> void:
    _skills = [basic_attack, second_attack, third_attack, block, dodge, ultimate]


func activate_basic_attack(pressed: bool) -> void:
    if not enabled: return
    _activate_skill.rpc(0, pressed)


func activate_secondary_attack(pressed: bool) -> void:
    if not enabled: return
    _activate_skill.rpc(1, pressed)


func activate_third_attack(pressed: bool) -> void:
    if not enabled: return
    _activate_skill.rpc(2, pressed)


func activate_block(pressed: bool) -> void:
    if not enabled: return
    _activate_skill.rpc(3, pressed)


func activate_dodge(pressed: bool) -> void:
    if not enabled: return
    _activate_skill.rpc(4, pressed)


func activate_ultimate(pressed: bool) -> void:
    if not enabled: return
    _activate_skill.rpc(5, pressed)


func cancel_skill() -> void:
    if not enabled: return
    if not _last_used_skill or is_zero_approx(_last_used_skill.execution): return
    _last_used_skill.cancel()


@rpc("reliable", "call_local")
func _activate_skill(index: int, pressed: bool) -> void:
    var skill = _skills[index]
    if not skill or not skill.enabled: return
    if _last_used_skill and _last_used_skill != skill and \
        not _last_used_skill.interruptable and not is_zero_approx(_last_used_skill.execution): return
    
    _last_used_skill = skill
    var key: String = "%s_ready" % skill.name
    skill.blackboard.set_value(key, pressed)


func reset() -> void:
    for skill in _skills:
        if not skill: continue
        skill.reset()
    enabled = true
