extends Node3D


var selected_hero: String = "barbarian" # FIXME


@onready var team_a = $Spawner/TeamA
@onready var team_b = $Spawner/TeamB


func _ready() -> void:
    $PauseMenu.exit_game.connect(exit_game)


func exit_game() -> void:
    var lobby_scene: PackedScene = load("res://lobby/lobby.tscn")
    var lobby: = lobby_scene.instantiate()
    get_tree().root.add_child(lobby)
    get_tree().root.remove_child(self)
    queue_free()


@rpc("any_peer", "reliable")
func spawn_hero(player_id: int, hero_id: String) -> void:
    var params: = {
        "id" = player_id,
        "character" = hero_id
    }
    
    var team: = _get_priority_team()
    var hero: = team.spawn(params)
    team.spawned.emit(hero)


func _get_priority_team() -> MultiplayerSpawner:
    var team_a_count: int = team_a.count
    var team_b_count: int = team_b.count
    
    if team_a_count == team_b_count: return [team_a, team_b].pick_random()
    return team_a if team_a_count < team_b_count else team_b
