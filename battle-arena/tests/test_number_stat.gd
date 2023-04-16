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
    _test_current_value(10, 3, 0.5, 19.5)


func test_min() -> void:
    number_stat.has_min_value = true
    number_stat.min_value = 5
    _test_current_value(10, -7, 0, 5)


func test_max() -> void:
    number_stat.has_max_value = true
    number_stat.max_value = 12
    _test_current_value(10, 0, 0.5, 12)
