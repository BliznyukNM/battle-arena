extends "res://map/map.gd"


func select_hero(hero_name: String) -> void:
    selected_hero = hero_name
    
    #FIXME
    for child in team_a.root.get_children(): child.queue_free()
    for child in team_b.root.get_children(): child.queue_free()
    
    spawn_hero(multiplayer.get_unique_id(), hero_name)
