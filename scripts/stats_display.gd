extends Control

var max_list_size: int = 8

var gold_transactions: Array[int] = StoredStats.gold_transactions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Panel/CurrentGoldLabel.text = str(StoredStats.gold_inventory)
	$Panel2/StoredGoldLabel.text = str(StoredStats.stored_gold)
	
	$Panel/TransactionList.clear()
	var last_transactions = gold_transactions.slice(-max_list_size, gold_transactions.size())
	last_transactions.reverse()
	for transaction in last_transactions:
		var added_transaction: int = $Panel/TransactionList.add_item(str(transaction))
		if transaction > 0:
			$Panel/TransactionList.set_item_custom_fg_color(added_transaction, Color(0.0, 1.0, 0.0, 1.0))
		elif transaction < 0:
			$Panel/TransactionList.set_item_custom_fg_color(added_transaction, Color(1.0, 0.0, 0.0, 1.0))
