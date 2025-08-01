extends Node

var PL_holdhands = false
var PR_holdhands = false
var player_in_range = false
var holding_hands = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PL_holdhands and PR_holdhands and player_in_range:
		holding_hands = true
		print("Condition met.")
	else:
		holding_hands = false	
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
