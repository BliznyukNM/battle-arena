extends GutTest


var number_stat: NumberStat


func before_all() -> void:
    number_stat = NumberStat.new()
    add_child(number_stat)


func after_all() -> void:
    number_stat.free()


func before_each() -> void:
    number_stat.base_value = 0
    number_stat.flat_modifier = 0
    number_stat.percentual_modifier = 0
    number_stat.has_min_value = false
    number_stat.has_max_value = false


func _test_current_value(base: float, flat: float, percentage: float, result: float) -> void:
    number_stat.base_value = base
    number_stat.flat_modifier = flat
    number_stat.percentual_modifier = percentage
    assert_eq(number_stat.current_value, result)


func test_base_10_flat_0_percentual_0() -> void:
    _test_current_value(10, 0, 0, 10)
    

func test_base_10_flat_3_percentual_0() -> void:
    _test_current_value(10, 3, 0, 13)
    

func test_base_10_flat_3_percentual_0_5() -> void:
    _test_current_value(10, 3, 0.5, 18)


func test_base_10_flat_2_percentual_minus_0_1() -> void:
    _test_current_value(10, 2, -0.1, 11)


func test_min() -> void:
    number_stat.has_min_value = true
    number_stat.min_value = 5
    _test_current_value(10, -7, 0, 5)
    
    
func test_no_min() -> void:
    number_stat.has_min_value = false
    number_stat.min_value = 5
    _test_current_value(10, -7, -0.5, -2)


func test_max() -> void:
    number_stat.has_max_value = true
    number_stat.max_value = 12
    _test_current_value(10, 5, 0.5, 12)


func test_no_max() -> void:
    number_stat.has_max_value = false
    number_stat.max_value = 12
    _test_current_value(10, 5, 0.5, 20.0)


func test_signal_emit() -> void:
    watch_signals(number_stat)
    number_stat.base_value = 10
    number_stat.percentual_modifier = 0.2
    assert_signal_emitted_with_parameters(number_stat, "changed", [10.0, 12.0])
    number_stat.current_value += 10
    assert_signal_emitted_with_parameters(number_stat, "changed", [12.0, 22.0])


func test_coherency() -> void:
    var another_stat: = NumberStat.new()
    add_child(another_stat)
    
    number_stat.base_value = 10
    number_stat.percentual_modifier = 0.5
    number_stat.flat_modifier = 2
    
    another_stat.percentual_modifier = 0.5
    another_stat.flat_modifier = 2
    another_stat.base_value = 10
    
    assert_eq(number_stat.current_value, another_stat.current_value)
    
    another_stat.free()


func test_current_value() -> void:
    _test_current_value(5, 2, 1, 12)
    number_stat.current_value += 10
    assert_eq(number_stat.current_value, 22.0)
    number_stat.current_value -= 5
    assert_eq(number_stat.current_value, 17.0)
    number_stat.flat_modifier += 2
    assert_eq(number_stat.current_value, 19.0)
