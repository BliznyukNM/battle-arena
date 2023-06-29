extends GutTest


func get_character_scene_path() -> String:
    return "res://characters/character.tscn"


var character: PackedScene = load(get_character_scene_path())
var character_instance: CharacterBody3D


func before_all() -> void:
    character_instance = character.instantiate()
    add_child(character_instance)


func after_all() -> void:
    character_instance.free()


func test_apply_damage() -> void:
    var health: NumberStat = character_instance.stats.get_stat("Health")
    var hitbox: HitBox = character_instance.get_node("HitBox")
    
    var previous_value: = health.current_value
    const damage: = 50
    hitbox.on_damage.emit(damage)
    assert_eq(health.current_value, previous_value - damage)


func test_heal() -> void:
    var health: NumberStat = character_instance.stats.get_stat("Health")
    var hitbox: HitBox = character_instance.get_node("HitBox")
    
    var previous_value: = health.current_value
    const heal: = 10
    hitbox.on_heal.emit(heal)
    assert_eq(health.current_value, previous_value + heal)


func test_overheal() -> void:
    var health: NumberStat = character_instance.stats.get_stat("Health")
    var hitbox: HitBox = character_instance.get_node("HitBox")
    
    const heal: = 1e20
    hitbox.on_heal.emit(heal)
    assert_eq(health.current_value, health.max_value)


func test_death() -> void:
    fail_test("Not implemented")


func test_movement_slowdown_on_attack() -> void:
    fail_test("Not implemented")
    
    """
    var movement: NumberStat = character_instance.stats.get_stat("MovementSpeed")
    var basic_attack = character_instance.skills.basic_attack
    var slowdown_modifier: ConditionalModifier = character_instance.modifiers.get_node("SlowdownOnBasicAttack")

    assert_eq(movement.percentual_modifier, 0.0)
    basic_attack.activate(true)
    simulate(slowdown_modifier, 1, 0.01)
    assert_eq(movement.percentual_modifier, -slowdown_modifier.effects[0].amount / 100.0)
    basic_attack.activate(false)

    await wait_seconds(basic_attack.execution.time_left)
    assert_eq(movement.percentual_modifier, 0.0)
    """

