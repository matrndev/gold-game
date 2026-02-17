extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.modulate = Color(0.001, 0.526, 1.0, 1.0)
		$DropSpeed.start()


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$DropSpeed.stop()


func _on_drop_speed_timeout() -> void:
	if StoredStats.gold_inventory > 0:
		StoredStats.stored_gold += 1
		StoredStats.gold_inventory -= 1
		StoredStats.add_transaction(-1, "Storage")
