extends MultiplayerSpawner


func _ready() -> void:
    spawn_function = _spawn


func _spawn(data: Dictionary) -> Node:
    var scene: = load(data.path) as PackedScene
    assert(scene)
    
    var instance: = scene.instantiate()
    if data.has("transform"): instance.transform = data.transform
    instance.tree_entered.connect(func(): instance.owner = owner)
    return instance
