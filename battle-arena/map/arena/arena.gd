extends "res://map/map.gd"


const MAX_WINS: = 3


@onready var _teams = [
    {
        spawner = $Spawner/TeamA,
        round_hud = "Rounds/RoundHUD/TeamA",
        wins = 0,
    },
    {
        spawner = $Spawner/TeamB,
        round_hud = "Rounds/RoundHUD/TeamB",
        wins = 0,
    }
]


func _ready() -> void:
    super._ready()
    
    multiplayer.peer_disconnected.connect(_on_peer_disconnected)
    
    if not multiplayer.is_server(): return
    
    for team in _teams:
        team.spawner.spawned.connect(_register_hero)
        
        for hero in team.spawner.get_spawned():
            _register_hero(hero)


func _register_hero(hero: Node) -> void:
    hero.on_dead.connect(_check_round_state)


func _get_winner_teams() -> PackedInt32Array:
    if _teams.all(func(team): return not team.spawner.are_all_dead()): return []
    
    var winners: = range(0, _teams.size())
    for i in _teams.size():
        if not _teams[i].spawner.are_all_dead(): continue
        winners.erase(i)
    return winners


func _check_round_state() -> void:
    var winners: = _get_winner_teams()
    if winners.is_empty(): return
    
    set_round_won.rpc(winners)
    await get_tree().create_timer(1.0).timeout
    
    for i in winners:
        if _teams[i].wins < MAX_WINS: continue
        
        end_match.rpc(i)
        await get_tree().create_timer(1.0).timeout
        end_match(i) # TODO: temp
        return
    
    for team in _teams:
        team.spawner.reset.rpc()


func exit_game() -> void:
    Matchmaking.leave_match()
    super.exit_game()


@rpc("reliable", "call_local")
func set_round_won(winners: PackedInt32Array) -> void:
    for i in winners:
        _teams[i].wins += 1
        var round_circle: Node = get_node("%s/Round%d" % [_teams[i].round_hud, _teams[i].wins])
        round_circle.is_full = true
    
    Engine.time_scale = 0.25
    create_tween().tween_property(Engine, "time_scale", 1.0, 1)


@rpc("reliable", "call_remote")
func end_match(winner: int) -> void:
    print("Winner is %s" % _teams[winner].spawner.name)
    exit_game()


func _on_peer_disconnected(id: int) -> void:
    if id == Engine.get_singleton("Multiplayer").SERVER_ID: exit_game()
