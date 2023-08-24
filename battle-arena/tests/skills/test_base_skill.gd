extends GutTest


var character: CharacterBody3D


func before_all() -> void:
    character = load("res://characters/character.tscn").instantiate()
    character.name = "Character"
    add_child(character)


func after_all() -> void:
    character.free()


func test_base_skill() -> void:
    var base_skill: = _get_base_skill()
    
    watch_signals(base_skill)
    
    base_skill.activate(true)
    assert_signal_emit_count(base_skill, "aiming_started", 1)
    assert_signal_emit_count(base_skill, "aiming_finished", 1)
    
    assert_signal_emit_count(base_skill, "executing_started", 1)
    assert_signal_emit_count(base_skill, "executing_finished", 1)
    
    base_skill.free()


func test_base_skill_aim() -> void:
    var base_skill: = _get_base_skill()
    const AIMING_TIME: = 1.0
    base_skill.aiming_time = AIMING_TIME
    
    watch_signals(base_skill)
    
    base_skill.activate(true)
    assert_signal_emit_count(base_skill, "aiming_started", 1)
    assert_signal_emit_count(base_skill, "aiming_finished", 0)
    
    await wait_seconds(AIMING_TIME + 0.1)
    
    assert_signal_emit_count(base_skill, "aiming_finished", 1)
    assert_signal_emit_count(base_skill, "executing_started", 1)
    assert_signal_emit_count(base_skill, "executing_finished", 1)
    
    base_skill.free()


func test_base_skill_execution() -> void:
    var base_skill: = _get_base_skill()
    const EXECUTING_TIME: = 1.0
    base_skill.executing_time = EXECUTING_TIME
    
    watch_signals(base_skill)
    
    base_skill.activate(true)
    assert_signal_emit_count(base_skill, "aiming_started", 1)
    assert_signal_emit_count(base_skill, "aiming_finished", 1)
    assert_signal_emit_count(base_skill, "executing_started", 1)
    assert_signal_emit_count(base_skill, "executing_finished", 0)
    
    await wait_seconds(EXECUTING_TIME + 0.1)
    
    assert_signal_emit_count(base_skill, "executing_finished", 1)
    
    base_skill.free()


func _get_base_skill() -> BaseSkill:
    var base_skill: BaseSkill = load("res://characters/skills/base_skill.tscn").instantiate()
    base_skill.tree_entered.connect(func(): base_skill.owner = character, CONNECT_ONE_SHOT)
    character.skills.add_child(base_skill)
    return base_skill
