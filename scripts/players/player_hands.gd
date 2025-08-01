extends CharacterBody2D

@onready var PH_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_left: CharacterBody2D = $"."
@onready var player_right: CharacterBody2D = $"."

const SPEED = 130.0 #NOTE: DEFAULT IS 300.0
const JUMP_VELOCITY = -300.0 #NOTE: DEFAULT IS -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("PL_jump") or ("PR_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#NOTE: THIS DOESN'T DO ANYTHING YET.
	#if Input.is_action_just_pressed("PL_action"): 
		#pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("PL_left", "PL_right" or ) or ("PR_left", "PR_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Flips the sprite TODO: Add to player_two
	if direction > 0.0: #You changed this from Brackeys to be 0.0, because it's a float now.
		PH_sprite.flip_h = false
	elif direction < 0.0:
		PH_sprite.flip_h = true
	
	#HOLDING HANDS TEST
	if Input.is_action_pressed("PL_holdhands"):
		GameManager.PL_holdhands = true
	elif Input.is_action_just_released("PL_holdhands"):
		GameManager.PL_holdhands = false
		
	#MOVEMENT
	if is_on_floor():
		if direction == 0.0:
			if GameManager.holding_hands:
				PH_sprite.play("idle_hands")
			else:
				PH_sprite.play("idle")
		else:
			if GameManager.holding_hands:
				PH_sprite.play("run_hands")
			else:
				PH_sprite.play("run")

	move_and_slide()

#func _on_holding_hands_collider_body_entered(body: Node2D) -> void:
	##if body.is_in_group("player") and GameManager.PR_holdhands:
	#if body.is_in_group("player"):
		#print("Player right wants to hold hands.")
		#if GameManager.PL_holdhands == true:
			#print("Player left wants to hold hands")
		#else:
			#print("Player left does not want to hold hands")
	#elif Input.is_action_just_released("PL_holdhands"):
		#GameManager.PL_holdhands = false



func _on_holding_hands_collider_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	GameManager.player_in_range = true


func _on_holding_hands_collider_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	GameManager.player_in_range = false
