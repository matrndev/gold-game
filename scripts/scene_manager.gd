extends Node


var mining_facility_scene: Node2D
var active_scene: Node

func _ready() -> void:
	mining_facility_scene = load("res://scenes/game.tscn").instantiate()
	get_tree().root.call_deferred("add_child", mining_facility_scene)

func go_to(path: String) -> void:
	#if path == "res://scenes/game.tscn":
		#if active_scene:
			#active_scene.queue_free()
			#active_scene = null
		#mining_facility_scene.visible = true
	#else:
		#mining_facility_scene.visible = false
		#if active_scene:
			#active_scene.queue_free()
			#active_scene = null
		#active_scene = load(path).instantiate()
		#get_tree().root.call_deferred("add_child", active_scene)
		
	if path == "res://scenes/game.tscn":
		if active_scene:
			active_scene.queue_free()
			active_scene = null
		mining_facility_scene.visible = true
	else:
		mining_facility_scene.visible = false
		if active_scene:
			active_scene.queue_free()
			active_scene = null
		active_scene = load(path).instantiate()
		get_tree().root.call_deferred("add_child", active_scene)
		
