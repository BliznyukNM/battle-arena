@tool


static func get_character(node: Node) -> Character:
    if node == node.get_tree().root: return null
    if node is Character: return node
    return get_character(node.get_parent())


static func try_add_scene(spawner: MultiplayerSpawner, scene_path: String) -> void:
    for i in range(spawner.get_spawnable_scene_count()):
        if spawner.get_spawnable_scene(i) == scene_path: return
    spawner.add_spawnable_scene(scene_path)

