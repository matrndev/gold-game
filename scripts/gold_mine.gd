extends Area2D

var current_gold: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	body.modulate = Color(1.0, 0.0, 0.0, 1.0)
	
	if body.name == "Player":
		body.gold_transactions.append(current_gold)
		
		body.current_gold += current_gold
		current_gold = 0
		update_gold_meter()


func _on_body_exited(body: Node2D) -> void:
	body.modulate = Color(1.0, 1.0, 1.0, 1.0)


func _on_gold_generator_timer_timeout() -> void:
	current_gold += 1
	update_gold_meter()
	
func update_gold_meter() -> void:
	$ColorRect/CurrentGoldLabel.text = str(current_gold)
