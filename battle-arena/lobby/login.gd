extends Control


var _config: = ConfigFile.new()


func _ready() -> void:
    _restore_login()


func on_login_pressed() -> void:
    if $Nickname.text.is_empty(): return
    _save_nickname()
    _load_home()


func _restore_login() -> void:
    var result: = _config.load("user://local.ini")
    if result == ERR_FILE_CANT_OPEN: return
    $Nickname.text = _config.get_value("auth", "login", "")


func _save_nickname() -> void:
    _config.set_value("auth", "login", $Nickname.text)
    _config.save("user://local.ini")


func _load_home() -> void:
    var home: Node = load("res://lobby/home.tscn").instantiate()
    get_tree().root.add_child(home)
    get_tree().root.remove_child(self)
    queue_free()
