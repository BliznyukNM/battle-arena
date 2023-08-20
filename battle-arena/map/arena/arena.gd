extends "res://map/online.gd"


@onready var home: = preload("res://lobby/home.tscn")


const MAX_WINS: = 3


var _teams = [
    {
        spawner = %TeamA,
        round_hud = "Rounds/RoundHUD/TeamA",
        wins = 0,
    },
    {
        spawner = %TeamB,
        round_hud = "Rounds/RoundHUD/TeamB",
        wins = 0,
    }
]


func _ready() -> void:
    super._ready()
    
    if not multiplayer.is_server(): return
    
    for team in _teams:
        team.spawner.spawned.connect(_register_hero)
        
        for hero in team.spawner.get_spawned():
            _register_hero(hero)


func _register_hero(hero: Node) -> void:
    hero.on_dead.connect(_check_round_state)


func _get_winner_teams() -> PackedInt32Array:
    var winners: = PackedInt32Array()
    for i in _teams.size():
        if _teams[i].spawner.get_spawned().any(func(member): return member.is_alive): continue
        winners.append(i)
    return winners


func _check_round_state() -> void:
    var winners: = _get_winner_teams()
    if winners.is_empty(): return
    
    set_round_won.rpc(winners)
    
    for i in winners:
        if _teams[i].wins >= MAX_WINS:
            end_match.rpc(i)
            await get_tree().create_timer(1.0).timeout
            end_match(i)
            return
        _teams[i].spawner.reset.rpc()


@rpc("reliable", "call_local")
func set_round_won(winners: PackedInt32Array) -> void:
    for i in winners:
        _teams[i].wins += 1
        var round_circle: Node = get_node("%s/Round%d" % [_teams[i].round_hud, _teams[i].wins])
        round_circle.is_full = true


@rpc("reliable", "call_remote")
func end_match(winner: int) -> void:
    print("Winner is %s" % _teams[winner].spawner.name)
    Matchmaking.leave_match()
    get_tree().change_scene_to_packed(home)
    
