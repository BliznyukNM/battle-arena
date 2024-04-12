@tool
extends MultiplayerSpawner


@export_range(1, 2, 1) var team_id = 1


@onready var root: = get_node(spawn_path)


var count: int:
    get: return root.get_child_count()


func get_spawned() -> Array:
    return root.get_children()


func are_all_dead() -> bool:
    return get_spawned().all(func(hero): return not hero.is_alive)


const Utils = preload("res://utils/spawner.gd")


func _ready() -> void:
    if Engine.is_editor_hint():
        const heroes_folder: = "res://characters/heroes"
        for hero in DirAccess.get_directories_at(heroes_folder):
            Utils.try_add_scene(self, "%s/%s/%s.tscn" % [heroes_folder, hero, hero])
        return
    
    spawn_function = _spawn
    spawned.connect(on_spawned)


func _spawn(params) -> Node:
    var hero_instance: Node = load("res://characters/heroes/%s/%s.tscn" % [params.character, params.character]).instantiate()
    hero_instance.name = str(params.id)
    hero_instance.player_id = params.id
    hero_instance.collision_layer = 1 << team_id
    hero_instance.position = [$PositionA, $PositionB, $PositionC].pick_random().position
    hero_instance.get_node("Input").set_multiplayer_authority(params.id)
    hero_instance.tree_entered.connect(func(): hero_instance.owner = owner)
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
