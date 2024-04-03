class_name Character extends CharacterBody3D


signal on_dead()


@export var player_id: int


@onready var stats: StatManager = get_node_or_null("Stats")
@onready var modifiers: ModifierManager = get_node_or_null("Modifiers")
@onready var skills: SkillManager = get_node_or_null("Skills")
@onready var processors: = get_node_or_null("Processors")
@onready var blackboard: = get_node_or_null("Blackboard")
@onready var skin: = get_node_or_null("Skin")
@onready var input: = get_node_or_null("Input")
@onready var hit_box: HitBox = get_node_or_null("HitBox")
@onready var hud: = get_node_or_null("HUD")
@onready var spawner: MultiplayerSpawner = get_node_or_null("LocalSpawner")


var is_alive: bool:
    get: return stats.get_stat("Health").current_value > 0.0


func _ready() -> void:
    reset()
    on_dead.connect(_on_death)


func _on_death() -> void:
    skills.enabled = false
    skin.play_death()
    hud.visible = false
    
    for processor in processors.get_children(): processor.set_process(false)


func _on_health_changed(old_value: float, new_value: float) -> void:
    if is_equal_approx(new_value, 0.0) or new_value < 0.0:
        on_dead.emit()


@rpc("authority", "call_local", "reliable")
func gain_energy(amount: int) -> void:
    var energy_stat: NumberStat = stats.get_stat("Energy")
    energy_stat.current_value += amount


func reset() -> void:
    stats.reset()
    modifiers.reset()
    skills.reset()
    
    skin.play_spawn()
    hud.visible = true
    for processor in processors.get_children(): processor.set_process(true)
