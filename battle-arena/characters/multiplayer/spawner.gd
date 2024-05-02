extends MultiplayerSpawner


@export var spawn_on_reset: Array[String]


func _ready() -> void:
    spawn_function = _spawn


func reset() -> void:
    if not is_multiplayer_authority(): return
    for child in get_node(spawn_path).get_children(): child.queue_free()
    for scene in spawn_on_reset: spawn({"path": scene})


func _spawn(data: Dictionary) -> Node:
    var scene: = load(data.path) as PackedScene
    assert(scene)
    
    var instance: = scene.instantiate()
    if data.has("transform"): instance.transform = data.transform
    instance.tree_entered.connect(func(): instance.owner = owner)
    if instance.has_method("init"): instance.init(data)
    return instance
