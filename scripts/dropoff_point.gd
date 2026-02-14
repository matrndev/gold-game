extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if StoredStats.gold_inventory > 0:
			print("dropped ", StoredStats.gold_inventory)
			StoredStats.stored_gold += StoredStats.gold_inventory
			StoredStats.gold_inventory = 0
