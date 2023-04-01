extends Control

@onready var click_sound = $Quit2/Click










func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Levels/game_level.tscn")


func _on_quit_2_pressed():
	get_tree().quit()


