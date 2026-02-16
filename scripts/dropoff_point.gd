extends Area2D



func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Player":
		body.modulate = Color(0.001, 0.526, 1.0, 1.0)
		if StoredStats.gold_inventory > 0:
			print("dropped ", StoredStats.gold_inventory)
			StoredStats.stored_gold += StoredStats.gold_inventory
			StoredStats.gold_inventory = 0


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.modulate = Color(1.0, 1.0, 1.0, 1.0)
