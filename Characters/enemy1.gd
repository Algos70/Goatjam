extends CharacterBody2D

@export var hp = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_hurt_box_hurt(damage):
	print(hp)
	if Input.is_action_pressed("attack"):
		hp -= damage
	if hp <= 0:
		queue_free() #if hp 0 or lower delete the enemy from the game
		
	move_and_slide()
