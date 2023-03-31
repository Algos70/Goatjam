extends CharacterBody2D
@export var mov_speed = 100

func _physics_process(_delta):
	
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("jump")
		
	)
	print(input_direction)

