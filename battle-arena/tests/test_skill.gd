extends GutTest


var target: CharacterBody3D
var hitbox: HitBox
var character: CharacterBody3D


func before_all() -> void:
    character = load("res://characters/character.tscn").instantiate()
    character.name = "Character"
    add_child(character)
    
    target = load("res://characters/character.tscn").instantiate()
    target.name = "Target"
    target.position = Vector3(0, 0, 3)
    target.collision_layer = 1 << 1
    hitbox = target.get_node("HitBox")
    add_child(target)


func after_all() -> void:
    character.free()
    target.free()


func test_base_skill() -> void:
    var base_skill: BaseSkill = load("res://skills/base_skill.tscn").instantiate()
    character.skills.add_child(base_skill)
    
    watch_signals(base_skill)
    base_skill.activate(true)
    assert_signal_emit_count(base_skill, "activated", 1)
    
    await wait_seconds(base_skill.cooldown.time_left / 2)
    
    base_skill.activate(true)
    assert_signal_emit_count(base_skill, "activated", 1)
    
    await wait_seconds(base_skill.cooldown.time_left)
    base_skill.activate(true)
    assert_signal_emit_count(base_skill, "activated", 2)


func test_basic_melee_attack_skill_area_0():
    var basic_melee: BaseSkill = load("res://skills/base_melee_attack_skill.tscn").instantiate()
    basic_melee.damage = 4
    basic_melee.range = 5
    character.skills.add_child(basic_melee)
    basic_melee.owner = character
    basic_melee._setup_collision_mask()
    watch_signals(hitbox)
    
    basic_melee.activate(true)
    await wait_frames(1)
    assert_signal_emitted(hitbox, "on_hit")
    
    basic_melee.free()
