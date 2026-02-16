extends Area2D

enum Locations {DROPOFF_MAZE, MINING_FACILITY}

@export var go_to: Locations

func _ready() -> void:
	match go_to:
		Locations.DROPOFF_MAZE:
			$ColorRect/Label.text = "Teleport to\nDropoff Destination"
		Locations.MINING_FACILITY:
			$ColorRect/Label.text = "Teleport to\nMining Facility"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		match go_to:
			Locations.DROPOFF_MAZE:
				$ColorRect/Label.text = "Teleport to Dropoff Destination"
				SceneManager.go_to("res://scenes/dropoff_maze.tscn")
			Locations.MINING_FACILITY:
				$ColorRect/Label.text = "Teleport to Mining Facility"
				SceneManager.go_to("res://scenes/game.tscn")
