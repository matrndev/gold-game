extends Area2D

enum Locations {DROPOFF_MAZE, MINING_FACILITY}

@export var go_to: Locations

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		match go_to:
			Locations.DROPOFF_MAZE:
				SceneManager.go_to("res://scenes/dropoff_maze.tscn")
			Locations.MINING_FACILITY:
				SceneManager.go_to("res://scenes/game.tscn")
