extends Control


@onready var rtt: Label = $RTT


var Multiplayer:
    get:
        if not Multiplayer: Multiplayer = Engine.get_singleton("Multiplayer")
        return Multiplayer


func _process(delta: float) -> void:
    rtt.text = "RTT: %f" % Multiplayer.rtt
