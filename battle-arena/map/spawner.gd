extends MultiplayerSpawner


@export_range(1, 2, 1) var team_id = 1
@export var hero_list: CharacterList


@onready var root: = $Root


var count: int:
    get: return root.get_child_count()


func _ready() -> void:
    spawn_function = _spawn
    spawned.connect(on_spawned)
    
    for hero in hero_list.characters:
        add_spawnable_scene(hero.resource_path)


func _spawn(params) -> Node:
    var hero_instance = load(get_spawnable_scene(params.character)).instantiate()
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
