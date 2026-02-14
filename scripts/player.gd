extends CharacterBody2D

@export var movement_speed = 300

var current_gold: int = StoredStats.gold_inventory
var gold_transactions: Array[int] = StoredStats.gold_transactions

func _physics_process(_delta) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * movement_speed
	
	if not velocity == Vector2.ZERO and randf() < 0.01: # losing gold while walking
		gold_transactions.append(-1)
		current_gold -= 1
	
	move_and_slide()
