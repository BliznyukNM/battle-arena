extends MultiplayerSpawner


func _ready() -> void:
    spawn_function = _spawn


func _spawn(data: Dictionary) -> Node:
    var scene: = load(data.path) as PackedScene
    assert(scene)
    
    var instance: = scene.instantiate()
    instance.transform = data.transform
    return instance
