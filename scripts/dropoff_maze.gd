extends Node2D

var enemy_scene


func _on_enemy_spawn_timer_timeout() -> void:
	enemy_scene = load("res://scenes/enemy.tscn").instantiate()
	enemy_scene.position.x = randi_range(0, 1152)
	enemy_scene.position.x = randi_range(0, 648)
	enemy_scene.health = randi_range(3, 10)
	enemy_scene.movement_speed = randf_range(100.0, 200.0)
	add_child(enemy_scene)
