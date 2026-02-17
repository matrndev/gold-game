extends CharacterBody2D

@export var movement_speed: float = 150.0
@export var health: int = 8
var movement_target_position: Vector2
var gold_stolen: int = 0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready() -> void:
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	$HealthLabel.text = str(health)
	$GoldStolenLabel.text = str(gold_stolen)
	
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
	gold_stolen += 1
	$GoldStolenLabel.text = str(gold_stolen)
	StoredStats.add_transaction(-1, "Enemy")

var tween: Tween
func _on_kill_button_pressed() -> void:
	$ColorRect.modulate = Color(0.26, 0.004, 0.161, 1.0)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($ColorRect, "modulate", Color.WHITE, 0.3)
	
	health -= 1
	$HealthLabel.text = str(health)
	if health == 0:
		queue_free()
