extends CharacterBody2D

@export var movement_speed: float = 170.0
var movement_target_position: Vector2

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready() -> void:
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	actor_setup.call_deferred()

func actor_setup() -> void:
	await get_tree().physics_frame
	
	set_movement_target(SceneManager.player_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(_delta: float) -> void:
	set_movement_target(SceneManager.player_position)
	
	if navigation_agent.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$StealingTimer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$StealingTimer.stop()


func _on_stealing_timer_timeout() -> void:
	if StoredStats.gold_inventory <= 0:
		return
	StoredStats.gold_inventory -= 1
	StoredStats.gold_transactions.append(-1)
