extends Control


signal select_hero(hero_name: String)


func on_hero_clicked(hero_name: String) -> void:
    select_hero.emit(hero_name)
