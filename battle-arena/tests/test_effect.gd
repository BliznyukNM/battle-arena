extends GutTest


var character: Node3D


func before_all() -> void:
    character = load("res://characters/character.tscn").instantiate()
    add_child(character)
    
    var movement: = NumberStat.new()
    movement.name = "Movement"
    character.stats.add_child(movement)


func after_all() -> void:
    character.free()


func test_basic_modifier_with_slowdown() -> void:
    var slowdown_effect: = EffectSlowdown.new()
    slowdown_effect.amount = 50
    
    var slowdown_modifier: = BaseModifier.new()
    slowdown_modifier.effects.append(slowdown_effect)
    character.modifiers.add_child(slowdown_modifier)
    
    var movement_stat: NumberStat = character.stats.get_stat("Movement")
    
    assert_eq(movement_stat.percentual_modifier, -slowdown_effect.amount / 100.0)
    slowdown_modifier.free()
    assert_eq(movement_stat.percentual_modifier, 0.0)


func test_conditional_modifier_with_slowdown() -> void:
    var slowdown_effect: = EffectSlowdown.new()
    slowdown_effect.amount = 39
    
    var conditional_modifier: = ConditionalModifier.new()
    conditional_modifier.effects.append(slowdown_effect)
    conditional_modifier.condition = "owner.visible"
    character.modifiers.add_child(conditional_modifier)
    
    var movement_stat: NumberStat = character.stats.get_stat("Movement")
    
    assert_eq(movement_stat.percentual_modifier, 0.0)
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
    var slowdown_effect: = EffectSlowdown.new()
    slowdown_effect.amount = 15
    
    var timed_modifier: = TimedModifier.new()
    timed_modifier.effects.append(slowdown_effect)
    timed_modifier.time = 10.0
    character.modifiers.add_child(timed_modifier)
    
    var movement_stat: NumberStat = character.stats.get_stat("Movement")
    
    assert_eq(movement_stat.percentual_modifier, 0.0)
    simulate(character, 1, 1)
    assert_eq(movement_stat.percentual_modifier, -slowdown_effect.amount / 100.0)
    assert_eq(timed_modifier._current_time, timed_modifier.time - 1)
    
    simulate(character, 1, timed_modifier._current_time)
    assert_true(timed_modifier.is_queued_for_deletion())
    await wait_frames(1)
    assert_eq(movement_stat.percentual_modifier, 0.0)
