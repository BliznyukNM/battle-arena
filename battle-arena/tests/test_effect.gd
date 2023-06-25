extends GutTest


var character: Node3D


func before_all() -> void:
    character = load("res://characters/character.tscn").instantiate()
    add_child(character)


func after_all() -> void:
    character.free()


func test_basic_modifier_with_slowdown() -> void:
    var movement_stat: NumberStat = character.stats.get_stat("MovementSpeed")
    assert_eq(movement_stat.percentual_modifier, 0.0)
    
    var slowdown_modifier: = BaseModifier.new()
    slowdown_modifier.name = "Slowdown"
    character.modifiers.add_modifier(slowdown_modifier)
    
    var slowdown_effect: = EffectSlowdown.new()
    slowdown_effect.amount = 50
    slowdown_modifier.add_effect(slowdown_effect)
    
    assert_eq(movement_stat.percentual_modifier, -slowdown_effect.amount / 100.0)
    slowdown_modifier.free()
    assert_eq(movement_stat.percentual_modifier, 0.0)


func test_conditional_modifier_with_slowdown() -> void:
    var movement_stat: NumberStat = character.stats.get_stat("MovementSpeed")
    assert_eq(movement_stat.percentual_modifier, 0.0)
    
    var conditional_modifier: = ConditionalModifier.new()
    conditional_modifier.condition = "owner.visible"
    conditional_modifier.name = "SlowdownOnVisible"
    character.modifiers.add_modifier(conditional_modifier)
    
    var slowdown_effect: = EffectSlowdown.new()
    slowdown_effect.amount = 39
    conditional_modifier.add_effect(slowdown_effect)
    
    simulate(character, 1, 0.1)
    assert_eq(movement_stat.percentual_modifier, -slowdown_effect.amount / 100.0)
    
    character.visible = false
    simulate(character, 1, 0.1)
    assert_eq(movement_stat.percentual_modifier, 0.0)
    
    conditional_modifier.free()
    assert_eq(movement_stat.percentual_modifier, 0.0)
    
    character.visible = true
    assert_eq(movement_stat.percentual_modifier, 0.0)


func test_timed_modifier_with_slowdown() -> void:
    var movement_stat: NumberStat = character.stats.get_stat("MovementSpeed")
    assert_eq(movement_stat.percentual_modifier, 0.0)
    
    var timed_modifier: = TimedModifier.new()
    timed_modifier.time = 10.0
    timed_modifier.name = "SlowdownDebuff"
    character.modifiers.add_modifier(timed_modifier)
    
    var slowdown_effect: = EffectSlowdown.new()
    slowdown_effect.amount = 15
    timed_modifier.effects.append(slowdown_effect)
    
    simulate(character, 1, 1)
    assert_eq(movement_stat.percentual_modifier, -slowdown_effect.amount / 100.0)
    assert_eq(timed_modifier._current_time, timed_modifier.time - 1)
    
    simulate(character, 1, timed_modifier._current_time)
    assert_true(timed_modifier.is_queued_for_deletion())
    await wait_frames(1)
    assert_eq(movement_stat.percentual_modifier, 0.0)
