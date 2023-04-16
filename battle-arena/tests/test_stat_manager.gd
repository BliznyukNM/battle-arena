extends GutTest


var stat_mananger_script: = load("res://stats/stats_manager.gd")
var stat_manager: Node


func before_all() -> void:
    stat_manager = Node.new()
    stat_manager.set_script(stat_mananger_script)
    
    const stat_name: = "BaseStat"
    var base_stat: = BaseStat.new()
    base_stat.name = stat_name
    stat_manager.add_child(base_stat)
    add_child(stat_manager)


func after_all() -> void:
    stat_manager.free()


func test_has_stat() -> void:
    assert_true(stat_manager.has_stat("BaseStat"))


func test_get_stat() -> void:
    var stat: BaseStat = stat_manager.get_stat("BaseStat")
    assert_not_null(stat)
    if is_failing(): return
    assert_eq(stat.name, "BaseStat")
