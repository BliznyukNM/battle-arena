extends Control

var target: Character:
    set(value):
        target = value
        _update_hud()

        
func _update_hud() -> void:
    $BottomHUD/LMB_button.register(target.skills.basic_attack)
    $BottomHUD/RMB_button.register(target.skills.second_attack)
    $BottomHUD/E_button.register(target.skills.third_attack)
    $BottomHUD/Q_button.register(target.skills.block)
    $BottomHUD/Space_button.register(target.skills.dodge)
    $BottomHUD/R_button.register(target.skills.ultimate)
    $ID.text = "ID: %d" % target.player_id
