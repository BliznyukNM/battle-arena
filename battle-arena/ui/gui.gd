extends Control


var target: Node:
	set(value):
		target = value
		_update_hud.call_deferred()


func _update_hud() -> void:
	$BottomHUD/LMB_button.register(target.skills.basic_attack)
	#$BottomHUD/RMB_button.register(target.skills.RMB_button)
	#$BottomHUD/Space_button.register(target.Space_button)
	#$BottomHUD/Q_button.register(target.skills.Q_button)
	#$BottomHUD/E_button.register(target.E_button)
	#$BottomHUD/R_button.register(target.R_button)
	$ID.text = "ID: %d" % target.player_id
