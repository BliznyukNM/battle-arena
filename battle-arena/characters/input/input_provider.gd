extends MultiplayerSynchronizer


signal on_basic_attack(pressed: bool)
signal on_secondary_attack(pressed: bool)
signal on_block(pressed: bool)
signal on_third_attack(pressed: bool)
signal on_dodge(pressed: bool)
signal on_ultimate(pressed: bool)
signal on_cancel()


@export var input_source: InputSource:
    set(value):
        input_source = value
        input_source.init(owner)


var move_direction: Vector2
var look_at_point: Vector3
var input_mask: int:
    set(value):
        if input_mask == value: return
        if multiplayer.is_server(): _process_input_mask(input_mask, value)
        input_mask = value


enum InputMapping {
    BASIC_ATTACK =  0b00000001,
    SECOND_ATTACK = 0b00000010,
    THIRD_ATTACK =  0b00000100,
    BLOCK =         0b00001000,
    DODGE =         0b00010000,
    ULTIMATE =      0b00100000,
    SHIFT =         0b01000000,
    CANCEL =        0b10000000,
}


func _process_input_mask(old_mask: int, new_mask: int) -> void:
    var xor_mask = old_mask ^ new_mask
    
    if xor_mask == 0: return
    
    if xor_mask & InputMapping.BASIC_ATTACK:
        on_basic_attack.emit(new_mask & InputMapping.BASIC_ATTACK > 0)
    if xor_mask & InputMapping.SECOND_ATTACK:
        on_secondary_attack.emit(new_mask & InputMapping.SECOND_ATTACK > 0)
    if xor_mask & InputMapping.THIRD_ATTACK:
        on_third_attack.emit(new_mask & InputMapping.THIRD_ATTACK > 0)
    if xor_mask & InputMapping.BLOCK:
        on_block.emit(new_mask & InputMapping.BLOCK > 0)
    if xor_mask & InputMapping.DODGE:
        on_dodge.emit(new_mask & InputMapping.DODGE > 0)
    if xor_mask & InputMapping.ULTIMATE:
        on_ultimate.emit(new_mask & InputMapping.ULTIMATE > 0)

 
func _process(delta: float) -> void:
    if is_multiplayer_authority():
        move_direction = input_source.get_move_direction()
        look_at_point = input_source.get_look_at_point()
        
        _process_action("basic_attack", InputMapping.BASIC_ATTACK)
        _process_action("secondary_attack", InputMapping.SECOND_ATTACK)
        _process_action("third_attack", InputMapping.THIRD_ATTACK)
        _process_action("block", InputMapping.BLOCK)
        _process_action("dodge", InputMapping.DODGE)
        _process_action("ultimate", InputMapping.ULTIMATE)
    else:
        move_direction = move_direction.move_toward(Vector2.ZERO, delta)
    
    # if input_source.is_cancel_just_pressed(): on_cancel.emit()


func _process_action(action: String, mask: int) -> void:
    if input_source.call("is_%s_just_pressed" % action):
        input_mask |= mask
    elif input_source.call("is_%s_just_released" % action):
        input_mask &= ~mask
