extends Node


@export var health: NumberStat
@export var barrier: NumberStat
@export var energy: NumberStat
@export var name_tag: TagStat


@onready var health_bar: = $SubViewport/HUD/Container/Health
@onready var barrier_bar: = $SubViewport/HUD/Container/Barrier
@onready var energy_bar: = $SubViewport/HUD/Container/Energy
@onready var progress_bar: = $SubViewport/HUD/Container/ProgressBar
@onready var effect_progress_bar: = $SubViewport/HUD/Container/EffectProgressBar

@onready var name_label: = $SubViewport/HUD/Container/Name
@onready var view: = $View
@onready var viewport: = $SubViewport


func _ready() -> void:
    _initialize_bar(health_bar, health)
    _initialize_bar(energy_bar, energy)
    _initialize_bar(barrier_bar, barrier)
    if name_tag: name_label.text = name_tag.current_value
    else: name_label.visible = false


func _initialize_bar(bar: ProgressBar, stat: NumberStat) -> void:
    if not stat:
        bar.visible = false
        return
    
    bar.max_value = stat.max_value
    bar.value = stat.current_value
    stat.changed.connect(func(old, new): bar.value = new)


func show_progress_bar(duration: float) -> void:
    progress_bar.execute(duration)


func hide_progress_bar() -> void:
    progress_bar.stop()


func on_timed_modifier_started(modifier: TimedModifier) -> void:
    effect_progress_bar.register_modifier(modifier)
