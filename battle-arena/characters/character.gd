extends CharacterBody3D


@onready var stats: = $Stats
@onready var effects: = $Effects
@onready var skills: = $Skills

@onready var skin: = get_node_or_null("Skin")
@onready var weapon: = get_node_or_null("Weapon")
