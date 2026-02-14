extends Area2D

@export var gold_generation_interval: float = 1.0

var current_gold: int

var active_miners: Array[Node2D]


func _ready() -> void:
	$GoldGeneratorTimer.wait_time = gold_generation_interval


func _on_body_entered(body: Node2D) -> void:
	body.modulate = Color(1.0, 0.0, 0.0, 1.0)
	
	if body.name == "Player":
		body.gold_transactions.append(current_gold)
		
		body.current_gold += current_gold
		current_gold = 0
		update_gold_meter()


func _on_body_exited(body: Node2D) -> void:
	body.modulate = Color(1.0, 1.0, 1.0, 1.0)


func update_gold_meter() -> void:
	$ColorRect/CurrentGoldLabel.text = str(current_gold)


func _on_mine_button_pressed() -> void:
	if $ButtonDebounceTimer.time_left > 0:
		return
	$ButtonDebounceTimer.start()
	add_gold(1)


func add_gold(gold_to_add: int = 1) -> void:
	current_gold += gold_to_add
	update_gold_meter()


func create_miner() -> bool:
	var miner_scene = load("res://scenes/miner.tscn")
	var miner: Node2D = miner_scene.instantiate()
	var placeholder_count = get_tree().get_nodes_in_group("miner_placeholders").size()
	var success: bool = false
	
	for i in range(placeholder_count):
		var placeholder = get_node("MinerPlaceholder" + str(i))
		
		if placeholder.get_children().size() == 1: # add new miner into placeholder if it's unoccupied
			miner.miner_id = i
			miner.connect("mined", add_gold)
			placeholder.add_child(miner)
			active_miners.append(miner)
			success = true
			break
	
	return success


func _on_add_miner_button_pressed() -> void:
	var miner_successfully_added: bool = create_miner()
	
	if not miner_successfully_added:
		$AddMinerButton.hide()
	
