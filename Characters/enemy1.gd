extends CharacterBody2D

@export var hp = 5
const IDLE_SPEED = 50
const CHASE_SPEED = 100

var turnBackTimer = 0
var isFacingLeft = true
var canInteract = false
var canDefend = true

var defenceCooldown = 0

var state = "idle"
var landed = false
var isOnEdge = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rng = RandomNumberGenerator.new()


@onready var detectionRange = $"detectionRange"
@onready var player = get_parent().get_node("PlayerSlave") #change player name

func _process(delta):
	if defenceCooldown > 0:
		defenceCooldown -= delta
	else:
		canDefend = true
		
	if turnBackTimer > 0:
		turnBackTimer -= delta
	if not is_on_floor():
		if not landed:
			velocity.y += gravity * delta
		else:
			if turnBackTimer <= 0:
				isOnEdge = true
	else:
		landed = true
	# handle idle state
	if state == "idle":
		if (isOnEdge and turnBackTimer <= 0):
			velocity.x *= -1
			isFacingLeft = not isFacingLeft
			isOnEdge = false
			turnBackTimer = 3
		else:
			velocity.x = IDLE_SPEED * (-1 if isFacingLeft else 1) 
	elif state == "detected":
		if player.position.x < position.x:
			velocity.x = -CHASE_SPEED
			isFacingLeft = true
		else:
			velocity.x = CHASE_SPEED
			isFacingLeft = false	
	# Move the enemy
	move_and_slide()		
	
	# Flip sprite to face direction of movement
	if velocity.x != 0:
		get_node("Sprite2D").flip_h = isFacingLeft
	
func on_player_attack():
	var choice = rng.randi_range(0, 1)
	if canDefend and choice == 0:
		defenceCooldown = 3
		canDefend = false
		return true
	return false
		

func _on_hurt_box_hurt(damage):
	var protected = on_player_attack()
	if (not protected):
		print(hp)
		if Input.is_action_pressed("attack"):
			hp -= damage
		if hp <= 0:
			queue_free() #if hp 0 or lower delete the enemy from the game
			
		move_and_slide()


func _on_detection_range_body_entered(body):
	if body.name == player.name:
		state = "detected"



func _on_detection_range_body_exited(body):
	if body.name == player.name:
		state = "idle"
