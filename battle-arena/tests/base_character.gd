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


func test_health_setup_correctly() -> void:
    var health: NumberStat = character_instance.stats.get_stat("Health")
    
    assert_not_null(health)
    assert_true(health.has_max_value)
    assert_true(health.has_min_value)
    assert_eq(health.current_value, health.max_value)


func test_has_damage_processor() -> void:
    assert_true(character_instance.has_node("DamageProcessor"))


func test_apply_damage() -> void:
    var health: NumberStat = character_instance.stats.get_stat("Health")
    var damage_processor = character_instance.get_node("DamageProcessor")
    
    var previous_value: = health.current_value
    const damage: = 50
    damage_processor.damage(damage)
    assert_eq(health.current_value, previous_value - damage)


func test_heal() -> void:
    var health: NumberStat = character_instance.stats.get_stat("Health")
    var damage_processor = character_instance.get_node("DamageProcessor")
    
    var previous_value: = health.current_value
    const heal: = 10
    damage_processor.heal(heal)
    assert_eq(health.current_value, previous_value + heal)


func test_overheal() -> void:
    var health: NumberStat = character_instance.stats.get_stat("Health")
    var damage_processor = character_instance.get_node("DamageProcessor")
    
    const heal: = 1e20
    damage_processor.heal(heal)
    assert_eq(health.current_value, health.max_value)


func test_death() -> void:
    var damage_processor = character_instance.get_node("DamageProcessor")
    watch_signals(damage_processor)
    damage_processor.damage(1e20)
    assert_signal_emitted(damage_processor, "death")


func test_movement_setup_correctly() -> void:
    var movement: NumberStat = character_instance.stats.get_stat("Movement")
    
    assert_not_null(movement)
    assert_true(movement.has_max_value)
    assert_true(movement.has_min_value)


func test_movement_slowdown_on_attack() -> void:
    var movement: NumberStat = character_instance.stats.get_stat("Movement")
    var basic_attack = character_instance.skills.basic_attack
    var slowdown_modifier: ConditionalModifier = character_instance.modifiers.get_node("SlowdownOnBasicAttack")

    assert_eq(movement.percentual_modifier, 0.0)
    basic_attack.activate(true)
    simulate(slowdown_modifier, 1, 0.01)
    assert_eq(movement.percentual_modifier, -slowdown_modifier.effects[0].amount / 100.0)
    basic_attack.activate(false)

    await wait_seconds(basic_attack.execution.time_left)
    assert_eq(movement.percentual_modifier, 0.0)
