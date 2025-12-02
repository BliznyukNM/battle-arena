@tool
extends "res://characters/skills/leaves/spawners/spawn.gd"


func _tick(delta: float) -> int:
	var character: Character = agent
	var options: Dictionary = blackboard.get_var("options", {})
	var projectile = _spawn(character, options)
	projectile.distance = options.get("distance", 0.0)
	projectile.damage = options.get("damage", 0.0)
	projectile.energy_gain = options.get("energy_gain", 0.0)
	projectile.speed = options.get("speed", 0.0)
	return SUCCESS
