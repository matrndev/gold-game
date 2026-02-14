extends Node2D

@export var miner_id: int = -1

signal mined

func _ready() -> void:
	$Label.text = "miner " + str(miner_id)


func _on_mine_timer_timeout() -> void:
	mined.emit()
