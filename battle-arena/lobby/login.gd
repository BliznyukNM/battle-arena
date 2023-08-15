extends Control


@onready var loader: = $Loader


var _config: = ConfigFile.new()


func _ready() -> void:
    _restore_login()


func on_login_pressed() -> void:
    if $Nickname.text.is_empty(): return
    _save_username()
    var result: = await Matchmaking.authenticate($Nickname.text)
    if result: loader.start_home()


func _restore_login() -> void:
    var result: = _config.load("user://local.ini")
    if result == ERR_FILE_CANT_OPEN: return
    $Nickname.text = _config.get_value("auth", "login", "")


func _save_username() -> void:
    _config.set_value("auth", "login", $Nickname.text)
    _config.save("user://local.ini")
