extends Node2D

var vector = Vector2(2,2)

const welcome = preload("res://UI/GUIStart.tscn")


func _ready():
	self.scale = vector
