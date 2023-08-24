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


func test_basic_melee_area_0():
    var basic_melee: = _get_base_melee_skill(5, 0)
    watch_signals(hitbox)
    
    basic_melee.activate(true)
    await get_tree().physics_frame
    assert_signal_emitted_with_parameters(hitbox, "on_damage", [basic_melee.damage])
    
    basic_melee.free()


func test_base_melee_rotated() -> void:
    var basic_melee: = _get_base_melee_skill(5, 0)
    watch_signals(hitbox)
    
    const ANGLE: = 30.0
    
    character.rotate_y(ANGLE)
    
    basic_melee.activate(true)
    await get_tree().physics_frame
    assert_signal_not_emitted(hitbox, "on_damage")
    
    character.rotate_y(-ANGLE)
    
    basic_melee.free()


func test_basic_melee_out_of_range() -> void:
    var basic_melee: = _get_base_melee_skill(1, 0)
    watch_signals(hitbox)
    
    basic_melee.activate(true)
    await get_tree().physics_frame
    assert_signal_not_emitted(hitbox, "on_damage")
    
    basic_melee.free()


func test_basic_melee_area_30() -> void:
    var basic_melee: = _get_base_melee_skill(5, 30)
    watch_signals(hitbox)
    
    target.position = Vector3(1, 0, 2)
    await get_tree().physics_frame
    basic_melee.activate(true)
    await get_tree().physics_frame
    assert_signal_emitted_with_parameters(hitbox, "on_damage", [basic_melee.damage])


func _get_base_melee_skill(hit_range: float, area: float) -> BaseSkill:
    var base_melee: BaseSkill = load("res://characters/skills/base_melee_attack_skill.tscn").instantiate()
    base_melee.tree_entered.connect(func(): base_melee.owner = character, CONNECT_ONE_SHOT)
    base_melee.hit_range = hit_range
    base_melee.area = area
    character.skills.add_child(base_melee)
    return base_melee
