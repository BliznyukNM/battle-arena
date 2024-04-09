extends "res://map/map.gd"


func _ready() -> void:
    super()
    
    for team in [team_a, team_b]:
        team.spawned.connect(_register_hero)


func _register_hero(hero: Node) -> void:
    hero.on_dead.connect(_respawn)


func _respawn() -> void:
    for team in [team_a, team_b]:
        team.reset()


func select_hero(hero_name: String) -> void:
    selected_hero = hero_name
    
    #FIXME
    for child in team_a.root.get_children(): child.queue_free()
    for child in team_b.root.get_children(): child.queue_free()
    
    spawn_hero(multiplayer.get_unique_id(), hero_name)
