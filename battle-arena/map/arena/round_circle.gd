@tool
extends TextureRect


@export var empty_texture: Texture2D
@export var full_texture: Texture2D

@export var is_full: bool:
    set(value):
        is_full = value
        texture = full_texture if value else empty_texture
