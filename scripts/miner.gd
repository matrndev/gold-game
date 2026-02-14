extends Node2D

@export var miner_id: int = -1
@export var miner_speed: float = 1.0

signal mined

func _ready() -> void:
	$Label.text = "miner " + str(miner_id)
	$MineTimer.wait_time = miner_speed


func _on_mine_timer_timeout() -> void:
	mined.emit()
