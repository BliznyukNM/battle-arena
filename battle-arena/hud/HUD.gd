extends Node


@export var health: NumberStat
@export var energy: NumberStat
@export var skill_progress: NumberStat
@export var name_tag: TagStat


@onready var health_bar: = $SubViewport/HUD/Container/Health
@onready var energy_bar: = $SubViewport/HUD/Container/Energy
@onready var progress_bar: = $SubViewport/HUD/Container/ProgressBar

@onready var name_label: = $SubViewport/HUD/Container/Name
@onready var view: = $View
@onready var viewport: = $SubViewport


func _ready() -> void:
    _initialize_bar(health_bar, health)
    _initialize_bar(energy_bar, energy)
    _initialize_bar(progress_bar, skill_progress)
    name_label.text = name_tag.current_value


func _initialize_bar(bar: ProgressBar, stat: NumberStat) -> void:
    if not stat: return
    bar.max_value = stat.max_value
    bar.value = stat.current_value
    stat.changed.connect(func(old, new): bar.value = new)


func on_skill_activated(skill: BaseSkill) -> void:
    progress_bar.register_skill(skill)
