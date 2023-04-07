extends Node3D


@export var spawnee: PackedScene
@export var cooldown: float = 2


@onready var spawner: = $Spawner
@onready var timer: = $Timer


func _ready() -> void:
    spawner.spawn_function = _spawn
    
    if not multiplayer.is_server():
        set_process(false)
        return
    
    timer.timeout.connect(spawner.spawn)
    spawner.spawn()


func _process(_delta: float) -> void:
    if spawner.get_child_count() == 0 and timer.is_stopped():
        timer.start(cooldown)


func _spawn(data: Variant) -> Node:
    var instance = spawnee.instantiate()
    instance.position = position
    return instance
