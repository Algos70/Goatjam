extends Control

@onready var Click = $Play/Click

func _ready():
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/game_level.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_play_mouse_entered():
	Click.play()
