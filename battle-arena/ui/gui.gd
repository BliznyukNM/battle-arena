extends Control

var target: Character:
	set(value):
		target = value
		_update_hud()

		
func _update_hud() -> void:
	if target.skills.basic_attack.valid: $BottomHUD/LMB_button.register(target.skills.basic_attack)
	if target.skills.second_attack.valid: $BottomHUD/RMB_button.register(target.skills.second_attack)
	if target.skills.third_attack.valid: $BottomHUD/E_button.register(target.skills.third_attack)
	if target.skills.block.valid: $BottomHUD/Q_button.register(target.skills.block)
	if target.skills.dodge.valid: $BottomHUD/Space_button.register(target.skills.dodge)
	if target.skills.ultimate.valid: $BottomHUD/R_button.register(target.skills.ultimate)
	$ID.text = "ID: %d" % target.player_id
