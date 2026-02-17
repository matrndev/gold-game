extends Control

var max_list_size: int = 8

var gold_transactions: Array[String] = StoredStats.gold_transactions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Panel/CurrentGoldLabel.text = str(StoredStats.gold_inventory)
	$Panel2/StoredGoldLabel.text = str(StoredStats.stored_gold)
	
	if StoredStats.gold_inventory >= 100:
		$Panel/CurrentGoldLabel.add_theme_color_override("font_color", Color("red"))
		$Panel/MaxGoldLabel.add_theme_color_override("font_color", Color("red"))
	else:
		$Panel/CurrentGoldLabel.add_theme_color_override("font_color", Color("white"))
		$Panel/MaxGoldLabel.add_theme_color_override("font_color", Color("#666666"))
	
	$Panel/TransactionList.clear()
	var last_transactions = gold_transactions.slice(-max_list_size, gold_transactions.size())
	last_transactions.reverse()
	for transaction in last_transactions:
		var transaction_description: String = transaction.get_slice(":", 1)
		var gold_changed: int = int(transaction.get_slice(":", 0))

		var added_transaction: int = $Panel/TransactionList.add_item("%d (%s)" % [gold_changed, transaction_description])
		if gold_changed > 0:
			$Panel/TransactionList.set_item_custom_fg_color(added_transaction, Color(0.0, 1.0, 0.0, 1.0))
		elif gold_changed < 0:
			$Panel/TransactionList.set_item_custom_fg_color(added_transaction, Color(1.0, 0.0, 0.0, 1.0))
		#elif gold_changed == 0:
			#$Panel/TransactionList.remove_item(added_transaction)
