class_name InputProvider extends MultiplayerSynchronizer


signal on_basic_attack(pressed: bool)
signal on_secondary_attack(pressed: bool)
signal on_block(pressed: bool)
signal on_third_attack(pressed: bool)
signal on_dodge(pressed: bool)
signal on_ultimate(pressed: bool)


@export var move_direction: Vector2
@export var look_at_point: Vector3
