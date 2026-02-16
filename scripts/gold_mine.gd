extends Area2D

var current_gold: int
var current_price: int
var active_miners: Array[Node2D]

func _ready() -> void:
	price_update(10)

func _on_body_entered(body: Node2D) -> void:
	body.modulate = Color(1.0, 0.0, 0.0, 1.0)
	
	if body.name == "Player":
		StoredStats.gold_transactions.append(current_gold)
		
		StoredStats.gold_inventory += current_gold
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

func price_update(new_price: int) -> void:
	current_price = new_price
	$ColorRect/AddMinerButton.text = "Upgrade (%d Gold)" % current_price

func add_gold(gold_to_add: int = 1) -> void:
	current_gold += gold_to_add
	update_gold_meter()


func create_miner() -> bool:
	var miner_scene = load("res://scenes/miner.tscn")
	var miner: Node2D = miner_scene.instantiate()
	var placeholder_count = find_children("MinerPlaceholder*", "Node2D", true, false).size()
	var success: bool = false
	print(placeholder_count)
	for i in range(placeholder_count):
		var placeholder = find_child("MinerPlaceholder" + str(i))

		if placeholder.get_children().size() == 1: # add new miner into placeholder if it's unoccupied
			miner.miner_id = i
			miner.name = "Miner" + str(randi())
			miner.connect("mined", add_gold)
			placeholder.add_child(miner)
			active_miners.append(miner)
			success = true
			$ColorRect/Label.text = "Gold Mine Level " + str(i + 1)
			if i == placeholder_count - 1: # if this is the last placeholder available
				$AddMinerButton.hide()
			break
	
	return success


func _on_add_miner_button_pressed() -> void:
	if StoredStats.stored_gold - current_price < 0:
		$NoGoldDialog.show()
		return
	
	var miner_successfully_added: bool = create_miner()
	
	if miner_successfully_added:
		StoredStats.stored_gold -= current_price
		price_update(current_price * 5)
	else:
		$AddMinerButton.hide()
	
