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
    
    base_skill.free()


func _get_basic_melee_skill(hit_range: float, area: float) -> BaseSkill:
    var basic_melee: BaseSkill = load("res://skills/base_melee_attack_skill.tscn").instantiate()
    basic_melee.hit_range = hit_range
    basic_melee.area = area
    basic_melee.setup(character)
    character.skills.add_child(basic_melee)
    return basic_melee


func test_basic_melee_area_0():
    var basic_melee: = _get_basic_melee_skill(5, 0)
    watch_signals(hitbox)
    
    basic_melee.activate(true)
    await wait_frames(2)
    assert_signal_emitted_with_parameters(hitbox, "on_damage", [basic_melee.damage])
    
    basic_melee.free()


func test_basic_melee_out_of_range() -> void:
    var basic_melee: = _get_basic_melee_skill(1, 0)
    watch_signals(hitbox)
    
    basic_melee.activate(true)
    await wait_frames(2)
    assert_signal_not_emitted(hitbox, "on_damage")
    
    basic_melee.free()


func test_basic_melee_area_30() -> void:
    var basic_melee: = _get_basic_melee_skill(5, 30)
    watch_signals(hitbox)
    
    target.position = Vector3(1, 0, 2)
    await wait_frames(2)
    basic_melee.activate(true)
    await wait_frames(2)
    assert_signal_emitted_with_parameters(hitbox, "on_damage", [basic_melee.damage])
