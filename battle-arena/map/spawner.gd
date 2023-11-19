extends MultiplayerSpawner


@export_range(1, 2, 1) var team_id = 1


@onready var root: = get_node(spawn_path)


var count: int:
    get: return root.get_child_count()


func get_spawned() -> Array:
    return root.get_children()


func are_all_dead() -> bool:
    return get_spawned().all(func(hero): return not hero.is_alive)


func _ready() -> void:
    spawn_function = _spawn
    spawned.connect(on_spawned)
    
    const heroes_folder: = "res://characters/heroes"
    for hero in DirAccess.get_directories_at(heroes_folder):
        add_spawnable_scene("%s/%s/%s.tscn" % [heroes_folder, hero, hero])


func _spawn(params) -> Node:
    var hero_instance = load("res://characters/heroes/%s/%s.tscn" % [params.character, params.character]).instantiate()
    hero_instance.name = str(params.id)
    hero_instance.player_id = params.id
    hero_instance.collision_layer = 1 << team_id
    hero_instance.position = $PositionA.position # TODO: temporary
    hero_instance.get_node("Input").set_multiplayer_authority(params.id)
    return hero_instance


func on_spawned(character: Node) -> void:
    if character.player_id != multiplayer.get_unique_id(): return
    
    %Camera.target = character
    %GUI.target = character
    character.input.input_source = load("res://characters/input/user_input.gd").new()


@rpc("reliable", "call_local")
func reset() -> void:
    for character in root.get_children():
        character.reset()
        character.position = $PositionA.position # FIXME: temporary
