extends Node


var mining_facility_scene: Node2D
var active_scene: Node

var player_position: Vector2

func _ready() -> void:
	mining_facility_scene = load("res://scenes/game.tscn").instantiate()
	get_tree().root.call_deferred("add_child", mining_facility_scene)

func _process(_delta: float) -> void:
	player_position = mining_facility_scene.get_child(0).position

func mining_scene_active(active: bool) -> void:
	# this below doesnt work, keep it disabled!
	# mining_facility_scene.process_mode = Node.PROCESS_MODE_INHERIT if active else Node.PROCESS_MODE_DISABLED # this is apparently something resembling a ternary operator in gdscript lol 
	
	for area in mining_facility_scene.find_children("*", "Area2D", true, false): # disable collisions with teleports and gold mines
		area.set_deferred("monitoring", active)
		area.set_deferred("monitorable", active)

	#for area in mining_facility_scene.find_children("WorldBoundary*", "CollisionShape2D", true, false): # make boundaries disabled
		#area.set_deferred("disabled", !active)
	
	# retain the player from the mining scene, but hide everything else
	for child in mining_facility_scene.get_children():
		if child.name != "Player":
			child.visible = active

func go_to(path: String) -> void:
	if path == "res://scenes/game.tscn":
		if active_scene:
			active_scene.queue_free()
			print("clearing act sc")
			active_scene = null
		mining_scene_active(true)
	else:
		mining_scene_active(false)
		if active_scene:
			active_scene.queue_free()
			print("clearing act sc")
			active_scene = null
		active_scene = load(path).instantiate()
		print("loading ", active_scene.name)
		get_tree().root.call_deferred("add_child", active_scene)
		
