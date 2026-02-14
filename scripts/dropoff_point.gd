extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.current_gold > 0:
			print("dropped ", body.current_gold)
			StoredStats.stored_gold += body.current_gold
			body.current_gold = 0
