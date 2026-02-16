extends Node2D

var enemy_scene


func _on_enemy_spawn_timer_timeout() -> void:
	enemy_scene = load("res://scenes/enemy.tscn").instantiate()
	enemy_scene.position.x = randi_range(0, 1152)
	enemy_scene.position.x = randi_range(0, 648)
	add_child(enemy_scene)
