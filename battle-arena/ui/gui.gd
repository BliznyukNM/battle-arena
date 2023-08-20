extends Control


var target: Node:
    set(value):
        target = value
        _update_hud.call_deferred()


func _update_hud() -> void:
    $BottomHUD/BaseSkill.register(target.skills.basic_attack)
    $BottomHUD/SecondarySkill.register(target.skills.secondary_attack)
    $BottomHUD/BlockSkill.register(target.skills.block)
    $BottomHUD/ThirdSkill.register(target.skills.third_attack)
    $BottomHUD/DodgeSkill.register(target.skills.dodge)
    $BottomHUD/UltimateSkill.register(target.skills.ultimate)
    $ID.text = "ID: %d" % target.player_id
