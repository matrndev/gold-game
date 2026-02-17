extends Node

var gold_inventory: int
var gold_transactions: Array[String]
var stored_gold: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func add_transaction(gold_changed: int, description: String) -> void:
	gold_transactions.append(str(gold_changed) + ":" + description)
	
