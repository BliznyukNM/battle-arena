@tool


static func try_add_scene(spawner: MultiplayerSpawner, scene_path: String) -> void:
    for i in range(spawner.get_spawnable_scene_count()):
        if spawner.get_spawnable_scene(i) == scene_path: return
    spawner.add_spawnable_scene(scene_path)
