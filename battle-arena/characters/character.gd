extends CharacterBody3D


signal on_dead(character)


@export var player_id: int


@onready var stats: StatManager = get_node_or_null("Stats")
@onready var modifiers: ModifierManager = get_node_or_null("Modifiers")
@onready var skills: SkillManager = get_node_or_null("Skills")
@onready var processors: = get_node_or_null("Processors")
@onready var skin: = get_node_or_null("Skin")
@onready var input: = get_node_or_null("Input")
@onready var hit_box: HitBox = get_node_or_null("HitBox")


func _on_health_changed(old_value: float, new_value: float) -> void:
    if new_value <= 0.0: on_dead.emit(self)


func reset() -> void:
    stats.reset()
    modifiers.reset()
    skills.reset()
