extends Character


enum Stance { HANDS = 0, AXE = 1 }
@export var stance: = Stance.AXE: set = update_stance


var is_recalling: bool:
	get: return false if not thrown_axe else thrown_axe.is_recalling
var thrown_axe: Node


func update_stance(value: int) -> void:
	stance = value
	if skin: skin.update_stance(Stance.find_key(stance))


func on_throw_axe(axe) -> void:
	if thrown_axe: thrown_axe.queue_free()
	thrown_axe = axe


@rpc("reliable", "call_local")
func recall_axe() -> void:
	assert(thrown_axe)
	thrown_axe.recall()


@rpc("reliable", "call_local")
func on_pickup_axe() -> void:
	if thrown_axe and is_multiplayer_authority(): thrown_axe.queue_free()
	
	# blackboard.set_var("axe_recalled", true)
	update_stance(Stance.AXE)
